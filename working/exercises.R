## Exercises for Ch. 3

source("similarity.R")
source("hashing.R")


## Exercise 3.3.1
#                                        
# Verify the theorem from Section 3.3.3, which relates the Jaccard
# similarity to the probability of minhashing to equal values, for the
# particular case of Fig. 3.2
#
# (a) Compute the Jaccard similarity of each of the pairs of columns
#     in Fig. 3.2.

sims <- c(
  jaccard(s1, s2),
  jaccard(s1, s3),
  jaccard(s1, s4),
  jaccard(s2, s3),
  jaccard(s2, s4),
  jaccard(s3, s4))

# (b) Compute, for each pair of the columns of that figure, the fraction
#     of the 120 permutations of the rows that make the two columns hash 
#     to the same value.

# row permutations (6 rows * 4 columns) = 120 
(factorial(6)/factorial(6-2)) * 4

# not sure why this is value added, moving on.


## Exercise 3.3.2 
# 
# Using the data from Fig. 3.4, add to the signatures of the columns
# the values of the following hash functions:
# 
# (a) h3(x) = 2x + 4 mod 5.
# (b) h4(x) = 3x - 1 mod 5.

# Figure 3.4: Hash functions computed for the matrix of Fig. 3.2
s1 <- c(0,3); s2 <- c(2); s3 <- c(1,3,4); s4 <- c(0,2,3)
x <- c(1,2,3,4,0); threex <- c(1,4,2,0,3)

hashlist <- list(h1,h2,h3,h4)
setlist <- list(s1,s2,s3,s4)

solution_3.3.2 <- computeMinhashSigs(hashlist, setlist)


## Exercise 3.3.3: In Fig. 3.5 is a matrix with six rows.
#
# (a) Compute the minhash signature for each column if we use the 
#     following three hash functions: h1(x) = 2x + 1 mod 6; 
#     h2(x) = 3x + 2 mod 6; h3(x) = 5x + 2 mod 6

s1 <- c(0,0,1,0,0,1); s2 <- c(1,1,0,0,0,0); s3 <- c(0,0,0,1,1,0)
s4 <- c(1,0,1,0,1,0); element <- c(0,1,2,3,4,5)
h1 <- function(x) { (2*x + 1) %% 6 }
h2 <- function(x) { (3*x + 2) %% 6 }
h3 <- function(x) { (5*x + 2) %% 6 }

hashlist <- list(h1,h2,h3)
setlist <- list(s1,s2,s3,s4)

# the initial solution thinks all columns are the same;
# this is obviously a problem so lets take a closer look at what 
# happened.
solution_3.3.3 <- computeMinhashSigs(hashlist, setlist)

# let's first switch the binary to their corresponding values.

s1 <- c(2,5); s2 <- c(0,1); s3 <- c(3,4); s4 <- c(0,2,4)
setlist <- list(s1,s2,s3,s4)

# this looks better but I'm not sure it's quite right.
# it looks like the h2 thinks each row is identical while
# h1 thinks they look nearly identical
solution_3.3.3 <- computeMinhashSigs(hashlist, setlist)






















## scratch 


# Figure 3.2: A matrix representing four sets
s1 <- unique(c("a","d"))
s2 <- unique(c("c"))
s3 <- unique(c("b","d","e"))
s4 <- unique(c("a","c", "d"))

setUnion <- union(s1,s2)
setUnion <- union(setUnion, s3)
setUnion <- union(setUnion, s4)

setMatrix <- matrix(nrow=length(setUnion),ncol=4)

matrixRes <- cbind(setUnion, setMatrix)
setList <- list(s1,s2,s3,s4)

# use a matrix as it looks in the book; figure 3.2
setList <- list(s1,s2,s3,s4)
fig_3.2 <- setsToMatrix(setList)
colnames(fig_3.2) <- c("row", "s1", "s2", "s3","s4")

# scratch
