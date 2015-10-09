#!/usr/bin/python3
""" Validate and fix data for csv files 

Tyler Brown; @tbonza; 2015; Licensing: MIT

1. There is an issue with unbalanced quotes in the example data. 
   Resolving it.

2. There is an issue with empty lines in the example data.
   Unresolved ***

"""
import argparse
import csv

# script arguments
parser = argparse.ArgumentParser()
parser.add_argument("csv", help="path to csv file")
parser.add_argument("cols", help="Number of columns in csv file")
args = parser.parse_args()

########################################################################
## Utils
########################################################################

def read_csv():
    with open(args.csv, 'r') as infile:
        read_data = infile.read()
        infile.close()

    return read_data

def write_csv(write_data):
    outfile = args.csv.split(".")
    _outfile = outfile[0] + "_valid."
    outfile = _outfile + outfile[1]

    try:
        with open(outfile, 'w'):
            csvwriter = csv.writer(outfile, delimiter=",",
                                   quotechar='"', quoting=csv.QUOTE_ALL)

            for line in write_data.split("\n"):
                csvwriter.writerow(line)

            outfile.close()

        return True

    except:
        return False


########################################################################
## Tests for data
########################################################################

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
        return False

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
        return False
    else:
        return True

def itemLenSanity(item):
    """ Check for 0 len """
    if len(item) > 0:
        return True
    else:
        return False


##################################################################
## Fixes for data
##################################################################

    
def fixNewline(read_data):
    """ Missing newline characters were found in the csv file; fixing """
    items = read_data.split(",")
    ncols = int(args.cols)

    fixed_items = []
    
    for item in items:

        count = 0

        while count < ncols:

            if not itemLenSanity(item): # problem area
                break
            
            if count == (ncols - 1) and item[-1] != "\n":
                item += "\n"

            count += 1

        fixed_items.append(item)

    # list to string
    new_csv = ""

    for fixed in fixed_items:

        col = 0
        while col < (ncols - 1):
            new_csv += fixed + ","
            col += 1

    return new_csv

def testerFixer(data):
    print("go go testerFixer")
    
    if not validateQuotes(data):
        print('validateQuotes failed')
        
    if not validateNewline(data):
        print ('validateNewline failed')
        data = fixNewline(data)
        testerFixer(data)

    if validateNewline(data) and validateQuotes(data):
        return data


def main():
    # setUp
    read_data = read_csv()

    # test & fix
    write_data = testerFixer(read_data)

    # write to file
    write_csv(write_data)

    print("Test complete")

if __name__ == "__main__":
    main()

        


