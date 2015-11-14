""" Pulled these scripts from record_linkage_example.py 

Used as a package for the demo ipython notebook
"""
from __future__ import print_function
from future.builtins import next

import os
import csv
import re
import collections
import logging
import optparse
import numpy

import dedupe
from unidecode import unidecode



def preProcess(column):
    """
    Do a little bit of data cleaning with the help of Unidecode and Regex.
    Things like casing, extra spaces, quotes and new lines can be ignored.
    """
    column = unidecode(column)
    column = re.sub('\n', ' ', column)
    column = re.sub('-', '', column)
    column = re.sub('/', ' ', column)
    column = re.sub("'", '', column)
    column = re.sub(",", '', column)
    column = re.sub(":", ' ', column)
    column = re.sub('  +', ' ', column)
    column = column.strip().strip('"').strip("'").lower().strip()
    #if not column :
    #    column = None # fix_2
    return column


def readData(filename):
    """
    Read in our data from a CSV file and create a dictionary of records, 
    where the key is a unique record ID.
    """

    data_d = {}

    with open(filename) as f:
        reader = csv.DictReader(f)
        for i, row in enumerate(reader):
            clean_row = dict([(k, preProcess(v)) for (k, v) in row.items()])
            try :
                clean_row['price'] = float(clean_row['price'][1:])
            except ValueError :
                clean_row['price'] = 0
            except TypeError: # fix_1
                clean_row['price'] = 0
            data_d[filename + str(i)] = dict(clean_row)

    return data_d

def descriptions(data_1, data_2) :
    for dataset in (data_1, data_2) :
        for record in dataset.values() :
            yield record['description']



