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
import sys
import logging

# script arguments
parser = argparse.ArgumentParser()
parser.add_argument("csv", help="path to csv file")
parser.add_argument("cols", help="Number of columns in csv file")
parser.add_argument("--log", help="Path of file for logging; string")
args = parser.parse_args()

# Global Variables
RECURSION_LIMIT = 3

########################################################################
## Utils
########################################################################

def log_it(path):
    logging.basicConfig(filename=path, level=logging.DEBUG,
                        format='%(asctime)s %(levelname)s %(message)s')
    
    logging.debug('Logging for validate.py\n')

def read_csv():
    logging.info('Reading csv file')
    with open(args.csv, 'r') as infile:
        read_data = infile.read()
        infile.close()

    return read_data

def write_csv(write_data):
    logging.info('Writing csv file')
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
            logging.info("Data written to csv file")

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
    logging.info('Validating quotes')
    for row in read_data.split("\n"):

        quote_count = 0
        for character in row:
            if character == '"':
                quote_count += 1

    if quote_count % int(args.cols) != 0:
        print("Unbalanced quote in CSV file")
        logging.warning("FAILED - Unbalanced quotes in CSV file")
        return False

    else:
        logging.info("PASSED - Quotes validated successfully")
        return True

def validateNewline(read_data):
    """ Check to see if correct number of
    newline characters """
    logging.info("Validating new line characters")
    items = read_data.split(",")

    newline_count = 0
    for itemChar in items:
        
         itemNewLines = len([character for character in itemChar
                         if character == "\n"])

         newline_count += itemNewLines

    if newline_count % int(args.cols) != 0:
        print("Missing newline characters")
        logging.warning("FAILED - Missing newline characters in CSV file")
        return False
    else:
        logging.info("PASSED - Newline characters validated successfully")
        return True

def validateCommas(read_data):
    """ Check to see if there's enough commas """
    row_count = 0
    for row in read_data.split("\n"):
        row_count += 1
        comma_count = 0

        row = list(row)
        while (len(row) - 2) >= 0:

            last_two = row.pop() + row.pop()
        
            if last_two[::-1] == ',"':
                comma_count += 1

    if comma_count / (int(args.cols) - 1) != row_count:
        print("Missing correct amount of commas")
        logging.warning("FAILED - Comma check in CSV file")
        return False

    else:
        print("Correct number of commas found")
        logging.info("PASSED - comma check")
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
    logging.info("Fixing newline characters")
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
    logging.info("Implementing testerFixer")
    
    global RECURSION_LIMIT
    RECURSION_LIMIT -= 1
    
    if RECURSION_LIMIT == 0:
        logging.error("Recursion limit reached")
        sys.exit("Recursion limit reached")
        
    if not validateQuotes(data):
        print('validateQuotes failed')

    if not validateCommas(data):
        print('validateCommas failed')
        
    if not validateNewline(data):
        print ('validateNewline failed')
        data = fixNewline(data)
        testerFixer(data)

    if validateNewline(data) and validateQuotes(data):
        logging.info("CSV file returned successfully")
        return data


def main():
    # setUp
    if args.log != None:
        log_it(args.log)
        logging.info("STARTED - validate.py")
        logging.info("CSV file path: {}".format(args.csv))
        logging.info("Number of cols: {}".format(args.cols))
    
    read_data = read_csv()

    # test & fix
    write_data = testerFixer(read_data)

    # write to file
    write_csv(write_data)

    print("Test complete")
    logging.info("COMPLETED - validate.py\n")

if __name__ == "__main__":
    main()

        


