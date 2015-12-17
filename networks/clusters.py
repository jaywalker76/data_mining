# coding: utf-8

import pandas as pd
import numpy as np
from nltk.metrics.distance import edit_distance
from itertools import combinations
import logging

def make_buckets(data, address):
    logging.info("make_buckets()")
    buckets = {}
    
    for x in data[address].values:
        addy, city, state, zipp = tuple(x)
    
        if addy in buckets:
            buckets[city].append(tuple(x))
        
        else:
            buckets[city] = [tuple(x)]

    logging.info("buckets length: {}".format(len(buckets)))
    return buckets

def merge_buckets(fbucket, second_bucket, nbuckets, buckets):
    
    if fbucket in nbuckets:
        
        nbuckets[fbucket].extend(buckets[second_bucket])
        
    else:
        
        nbuckets[fbucket] = buckets[second_bucket]
        
    return nbuckets
    
def close_enough_buckets(first_bucket, second_bucket, dist):
    
    if first_bucket == second_bucket:
        return False
    
    elif edit_distance(first_bucket, second_bucket) <= dist:
        return True
    
    else:
        return False

def merge_similar_buckets(buckets, dist):

    logging.info("merge_similar_buckets()")
    
    nbuckets = {}
    
    for first_bucket in buckets.keys():
        
        sim = False

        for second_bucket in buckets.keys():
            
            if type(first_bucket) == str and \
               type(second_bucket) == str:
                
                fbucket = first_bucket.upper()
                sbucket = second_bucket.upper()
            
                if close_enough_buckets(fbucket, sbucket, dist):
                
                    sim = True
                
                    nbuckets = merge_buckets(fbucket, second_bucket, 
                                             nbuckets, buckets)
                
        if not sim:
            
            if type(first_bucket) == str:
                fbucket = first_bucket.upper()
            else:
                fbucket = ""
                
            nbuckets[fbucket] = buckets[first_bucket]
             
    return nbuckets
        
def merge_clusters(cluster, clusters, item):
    """ Merge clusters from addy_list """
    
    if cluster in clusters:
        
        clusters[cluster].extend(item)
        
    else:
        clusters[cluster] = [item]
        
    return clusters

def array_chunks(addy_list, chunk_size):
    """ Break an array into chunks given the chunk size """
    remainder = len(addy_list) % chunk_size
    iterations = int(len(addy_list) / chunk_size)

    if remainder != 0:
        iterations += 1
        
    chunk_num = 0
    chunks = {}
    chunking = True
    chunker = 0

    while iterations > 0:

        chunks[chunk_num] = addy_list[chunker:chunk_size]
        chunk_num += 1
        chunker += chunk_size

        iterations -= 1
        
        if iterations == 1 and remainder != 0:
            chunk_size += remainder

        else:
            chunk_size += chunk_size

    return chunks

def chunk_compare():
    """ Compare chunks and recombine if necessary """
    # do what was done in check_sim()

    

    
    pass


    

def manage_array(addy_list, chunk_size):
    """ We need a way to compare large arrays of strings

    Most of the buckets contain a small number of strings
    like 8. Other buckets contains something like 767. Since
    we want to avoid comparing more than 50 items at a time 
    (arbitrary but reasonable assumption) we're going to have
    to figure out a way to break up the array so compared items
    are more likely to be similar.

    'Close enough' approach:

        We're going to do a standard deviation comparison. Take the
        similarity score of items within 50 item buckets. If the 
        standard deviation of comparisons within that bucket is less
        than 2, then hold out the string with a mean score.

        Else if the standard deviation is greater than 2, recombine
        the buckets into another group of 50. 

        Else do no more than three iterations.

    Returns:
        dict, clusters where key is integer, value is list of 
        corresponding addresses.
    """
    addy_size = len(addy_list)

    # break into chunks
    addy_list = addy_list.sort()
    chunks = array_chunks(addy_list, chunk_size)

    # compare & rechunk if necessary
    

    


    


def check_sim(addy_list, dist, cluster, clusters):
    """ Check a list of addresses for string similarity """

    logging.info("check_sim()")
    logging.debug("addy_list size: {}".format(len(addy_list)))
    
    for item in addy_list:

        #logging.debug("Verify item: {}".format(item))
        
        sim = False
        
        for pair in addy_list:
            
            sitem = str(item)
            spair = str(pair)
                
            if close_enough_buckets(sitem, spair, dist):
                
                sim = True
                
                clusters = merge_clusters(cluster, clusters, 
                                          item)
                
        if not sim:
            
            other = cluster + 1
            clusters[other] = item
            
    return clusters

def cluster_addresses(addy_buckets, dist):
    
    logging.info("cluster_addresses()")
    clusters = {}
    cluster = 0
        
    for key in addy_buckets.keys():

        logging.debug("verify key: {}".format(key))
        
        clusters = check_sim(addy_list= addy_buckets[key], 
                      dist = 5, cluster = cluster, 
                      clusters = clusters)
        
    return clusters


if __name__ == "__main__":

    # logging
    logging.basicConfig(filename='clusters.log', level=logging.DEBUG,
                        format='%(asctime)s %(levelname)s %(message)s')


    # specify data
    logging.debug("STARTING clusters.py")
    data = pd.read_csv('data/Food_Establishment_Inspections.csv')
    logging.debug("data read successfully")
    address = ['Address','City','State','Zip']
    buckets = make_buckets(data, address)
    logging.debug("buckets created successfully")
    addy_buckets = merge_similar_buckets(buckets, 5)
    logging.debug("address buckets merged successfully")


    # # Find similar addresses
    # 
    # Find similar addresses by looking within each bucket. If an 
    # address is similar, then place the similar addresses in a 
    # numbered cluster. Clusters will be placed in a dictionary where
    # each key is mapped to a number.

    logging.debug("address cluster mapping STARTING")
    clusters = cluster_addresses(addy_buckets= addy_buckets, dist=5)
    logging.debug("address cluster mapping COMPLETED")




