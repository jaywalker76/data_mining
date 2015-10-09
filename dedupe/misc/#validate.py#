#!/usr/bin/python3
""" Validate data for csv files 

There was an issue with unbalanced quotes in the example data. Resolving it.
"""
import sys
import re
import argparse

# script arguments
parser = argparse.ArgumentParser()
parser.add_argument("csv", help="path to csv file")
args = parser.parse_args()

# regex to find unbalanced quotes
#pattern = """(?=\s)[^"]*(?<=\s+)")"""


with open(args.csv, 'r') as infile:
    read_data = infile.read()
    infile.close()

# validate quotes
for item in read_data.split("\n"):
    items = item.split(",")
    
    char = 0
    startquote = False
    endquote = False
    while char < len(item):
        if startquote == False and char == '"':
            startquote = True
            char += 1

        elif startquote == True and char == '"':
            endquote = True
            char += 1

        else:
            char += 1

    if not endquote:
        print("Unbalanced quote in CSV file: {}".format(item))
        raise(ValueError)

print("Test complete")

        


