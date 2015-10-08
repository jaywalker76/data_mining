#!/usr/bin/python3
import csv, sys
import re
import argparse

# script arguments
parser = argparse.ArgumentParser()
parser.add_argument("csv", help="path to csv file")
args = parser.parse_args()

# regex to find unbalanced quotes
pattern = """(?=\s)[^"]*(?<=\s+)")"""

# 
with open(args.csv, 'r') as infile:
    reader = csv.reader(infile)
    #try:
    for row in reader:
        pass
    #except csv.Error as e:
    #    sys.exit('file {}, line {}: {}'.format(args.csv,
    #                                           reader.line_num, e)

