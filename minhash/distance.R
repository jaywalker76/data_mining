## 3.5 Distance Measures

## 3.5.2 Euclidean Distances
#
# The most conventional distance measure in this space, which we shall 
# refer to as the L2-norm, is defined as the square of the distance
# in each dimension, sum the squares, and take the positive square root.


## 3.5.3 Jaccard Distance
#
# As mentioned at the beginning of the section, we define the Jaccard
# distance of sets by d(x,y) = 1 - SIM(x,y). This is, the Jaccard 
# distance is 1 minus the ratio of the sizes of the intersections and 
# union of sets x and y.


## 3.5.4 Cosine Distance
# 
# The cosine distance makes sense in spaces that have dimensions, 
# including Euclidean spaces and discrete version of Euclidean spaces, 
# such as spaces where points are vectors with integer components or 
# boolean (0 or 1) components.


## 3.5.5 Edit Distance
#
# This distance makes sense when points are strings. The distance
# between two strings is the smallest number of insertions and
# deletions of single characters that will convert x to y.

## 3.5.6 Hamming Distance
#
# Given a space of vectors, we define the Hamming distance between
# two vectors to be the number of components in which they differ. Most
# commonly, Hamming distance is used when the vectors are boolean.

# used stringdist library for edit distance


