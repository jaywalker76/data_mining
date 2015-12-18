""" Taking a vector based approach to address similarity

Previous attempt, clusters.py, was buggy and required too many
data structures. We're going to move past that naive approach and
utilize some matrix operations to cluster the addresses.

End result should be:

|Address|City |Zip  |Cluster|
|124 Rue|Paris|02343|3      |


"""
print(__doc__)

import pandas as pd
from nltk.metrics.distance import edit_distance




if __name__ == "__main__":

    # logging
    logging.basicConfig(filename='clusters.log', level=logging.DEBUG,
                        format='%(asctime)s %(levelname)s %(message)s')


    # specify data
    logging.debug("STARTING linear.py")
    data = pd.read_csv('data/Food_Establishment_Inspections.csv')
    logging.debug("data read successfully")
    address = ['Address','City','State','Zip']
