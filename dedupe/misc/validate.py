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
parser.add_argument("cols", help="Number of columns in csv file")
args = parser.parse_args()

def read_csv():
    with open(args.csv, 'r') as infile:
        read_data = infile.read()
        infile.close()

    return read_data




# tests for data

def validateQuotes(read_data):
    """ Resolving CSV input error

    Exception in thread "main" 
    no.priv.garshol.duke.DukeException: 
    Unbalanced quote in CSV file

    """
    for row in read_data.split("\n"):

        quote_count = 0
        for character in row:
            if character == '"':
                quote_count += 1

    if quote_count % int(args.cols) != 0:
        print("Unbalanced quote in CSV file")
        raise(ValueError)

    else:
        return True

def validateNewline(read_data):
    """ Check to see if correct number of
    newline characters """
    items = read_data.split(",")

    newline_count = 0
    for itemChar in items:
        
         itemNewLines = len([character for character in itemChar
                         if character == "\n"])

         newline_count += itemNewLines

    if newline_count % int(args.cols) != 0:
        print("Missing newline characters")
        raise(ValueError)
    else:
        return True


def main():
    # setUp
    read_data = read_csv()

    # tests
    assert validateQuotes(read_data)
    assert validateNewline(read_data)


    print("Test complete")

if __name__ == "__main__":
    main()

        


