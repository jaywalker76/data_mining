## Hash functions associated with Ch. 3 (finding similar items)

source("similarity.R")

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
  main_set <- sort(unique(unlist(setList)))
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

computeDemoMinhashSigs <- function(h1, h2, fig_3.2){
  ## signature matrix computation (not automated)
  ## See Example 3.8

  # initially, the matrix consists of all infinities
  m <- matrix(data=Inf, nrow=2,ncol=5)
  colnames(m) <- c("hash","s1","s2","s3","s4")
  
  # first, we consider row 0 of figure 3.4
  # find the 1's in row 0 
  m[1,2] <- h1(0)
  m[1,5] <- h1(0)
  m[2,2] <- h2(0)
  m[2,5] <- h2(0)

  # now, we move to the row numbered 1 in Fig. 3.4 This row has 1 only
  # in s3, and its hash values are h1(1) = 2 and h2(1) = 4.
  m[1,4] <- h1(1)
  m[2,4] <- h2(1)

  # the row of Fig 3.4 numbered 2 has 1's in the columns for s2 and s4,
  # and its hash values are h1(2) = 3 and h2(2) = 2. We could change the
  # the values in the signature for s4, but the values in this column of
  # the signature matrix, [1,2], are each less than the corresponding
  # hash values [3,2].
  

  # less than
  if (m[1, 5] > h1(2)){
    m[1,5] <- h1(2)
  }
  if (m[2, 5] > h2(2)){
    m[2, 5] <- h2(2)
  }

  # we know s2 should be changed
  m[1,3] <- h1(2)
  m[2,3] <- h2(2)

  # next comes the row numbered 3 in Fig. 3.4. Here, all columns but s2
  # have 1, and the hash balues are h1(3) = 4 and h2(3) = 0. The value
  # 4 for h1 exceeds what is already in the signature matrix for all the
  # columns, so we shall not change any values in the first row of the
  # signature matrix. However, the value 0 for h2 is less than what is 
  # already present, so we lower SIG(2,1), SIG(2,3) and SIG(2,4) to 0.
  # Note that we cannot lower SIG(2,2) because the column for s2 in 
  # Fig. 3.4 has 0 in the row we are currently considering.

  # less than
  if (m[2,2] > h2(3)){
    m[2,2] <- h2(3)
  }
  if (m[2,4] > h2(3)){
    m[2,4] <- h2(3)
  }
  if (m[2,5] > h2(3)){
    m[2,5] <- h2(3)
  }

  # finally, consider the row of Fig. 3.4 numbered 4. h1(4) = 0 and 
  # h2(4) = 3. Since row 4 has 1 only in the column for s3, we only 
  # compare the current signature column for that set, [2,0] with the 
  # hash values [0,3]. Since 0 < 2, we change SIG(1,3) to 0, but since
  # 3 > 0 we do not change SIG(2,3). The final signature matrix is:
  if (m[1,4] > h1(4)) {
    m[1,4] <- h1(4)
  }
  if (m[2,4] > h2(4)) {
    m[2,4] <- h2(4) 
  }
  
  return(m)
  
}

updateMinhashSig <- function(m, colint, hash, rrow, jrow){
  ## update minhash signature for TRUE in colint

  # where should m be updated?
  # is the hash less than infinity?
  # is the hash less than the previous hash?

  if (TRUE %in% (m[rrow,] * colint > h1(jrow))){
    m[rrow, ][m[rrow,] * colint > h1(jrow)] <- h1(jrow)
    return(m)
  }
  else { return(m) }

}

computeMinhashSigs <- function(hash, sets) {
  ## more general implmentation of minhash

  # set of all shingles
  main_set <- sort(unique(unlist(sets)))

  # matrix to be populated with minhash signatures
  m <- matrix(data=Inf, nrow=length(hash),
              ncol=length(main_set))

  # loop through all sets and hash functions
  hashes <- unlist(hash)

  
  for (hash in hashes) { # converting this to matrix multiplication
    jrow <- 0
    rrow <- 1
    
    for (set in sets) {  # would be ideal

      # check to see where it exists
      colint <- ifelse(main_set %in% set, 1,0)
      
      # update minhash signature where 1
      
      m <- updateMinhashSig(m, colint, hash, rrow, jrow)
      
      jrow = jrow + 1
      rrow = rrow + 1
    }
  }

}


# scratch work
fig <- c(1,2,3,4,5)
s1 <- c(1,2,3)
s2 <- c(4,5,6,7)
s3 <- c(4,5,2,3)




