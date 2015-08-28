## Hash functions associated with Ch. 3 (finding similar items)

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

# matrix representation of sets
setsToMatrix <- function(setList){
  main_set <- unique(unlist(setList))
  out <- matrix(data = main_set)
  for (item in setList){
    column <- as.numeric(main_set %in% item)
    out <- cbind(out,column)
  }
  return(as.matrix(out))
}

## Exercise 3.3.1
#                                        
# Verify the theorem from Section 3.3.3, which relates the Jaccard
# similarity to the probability of minhashing to equal values, for the
# particular case of Fig. 3.2
#
# (a) Compute the Jaccard similarity of each of the pairs of columns
#     in Fig. 3.2.

source("similarity.R")

sims <- c(
  jaccard(s1, s2),
  jaccard(s1, s3),
  jaccard(s1, s4),
  jaccard(s2, s3),
  jaccard(s2, s4),
  jaccard(s3, s4))

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

# hash functions from example
h1 <- function(x) { (x + 1) %% 5 }
h2 <- function(x) { (3*x + 1) %% 5 }

# hash functions from exercise 3.3.2
h3 <- function(x) { (2*x + 4) %% 5 }
h4 <- function(x) { (3*x - 1) %% 5 }

# reference rows in R with a 0 index
myrow <- function(x) { x + 1 }

# use a matrix as it looks in the book; figure 3.2
setList <- list(s1,s2,s3,s4)
fig_3.2 <- setsToMatrix(setList)
colnames(fig_3.2) <- c("row", "s1", "s2", "s3","s4")

computeSigs <- function(h1, h2, fig_3.2){
  ## signature matrix computation 

  # initially, the matrix consists of all infinities
  m <- matrix(nrow=2,ncol=4, value=Inf)
  
  # first, we consider row 0 of figure 3.4
  # find the 1's in row 0
  m[1, ] <- ifelse(fig_3.2[1, ] == 1,h1(0),Inf)
  m[2, ] <- ifelse(fig_3.2[1, ] == 1,h2(0),Inf)

  # now, we move to the row numbered 1 in Fig. 3.4 This row has 1 only
  # in s3, and its hash values are h1(1) = 2 and h2(1) = 4.
  
  

  
}
