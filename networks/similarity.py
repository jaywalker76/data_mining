
# coding: utf-8

# In[10]:

import pandas as pd
import networkx as nx
from nltk.metrics.distance import edit_distance
import matplotlib.pyplot as plt


# In[2]:

G = nx.DiGraph()


# In[3]:

data = pd.read_csv('data/Food_Establishment_Inspections.csv')


# In[6]:

address = ['Address','City','State','Zip']
print(data.columns)


# In[9]:

address_data = [tuple(x) for x in data[address].values]
print(address_data[0])


# In[11]:

# Sweet, let's build the directed graph


# In[12]:

G.add_nodes_from(address_data)


# In[ ]:

nx.draw(G, cmap=plt.get_cmap('jet'))


# In[ ]:



