## Hash functions associated with Ch. 3 (finding similar items)


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

# hash functions from example
h1 <- function(x) { (x + 1) %% 5 }
h2 <- function(x) { (3*x + 1) %% 5 }

# hash functions from exercise 3.3.2
h3 <- function(x) { (2*x + 4) %% 5 }
h4 <- function(x) { (3*x - 1) %% 5 }


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

updateMinhashSig <- function(m, colint, hash, hrow, jrow){
  ## update minhash signature for TRUE in colint

  # where should m be updated?
  # is the hash less than infinity?
  # is the hash less than the previous hash?

  mmultiply <- m[hrow,] * colint > hash(jrow)
    
  if (TRUE %in% (mmultiply)){
    m[hrow,][mmultiply] <- hash(jrow)
    return(m)
  }
  else { return(m) }

}

computeMinhashSigs <- function(hashlist, setlist) {
  ## more general implmentation of minhash

  # set of all shingles
  main_set <- sort(unique(unlist(setlist)))

  # matrix to be populated with minhash signatures
  m <- matrix(data=Inf, nrow=length(hashlist),
              ncol=length(setlist))

  # loop through all sets and hash functions
  #hashes <- unlist(hashlist)

  hrow <- 1
  sm <- setsToMatrix(setlist)
  
  for (hash in hashlist) { # converting this to matrix multiplication
    jrow <- 0

    for (row_num in 1:nrow(sm)) { # would be ideal

      # check each row to see where it exists
      colint <- sm[row_num, 2:length(sm[1,])]

      # update minhash signature where 1
      m <- updateMinhashSig(m, colint, hash, hrow, jrow)

      # increment jrow for hash function output
      jrow = jrow + 1
    }

    # increment hash row for signature table
    hrow = hrow + 1
  }
  return(m)
}

hashPermuteInduc <- function(hashlist) {
  ## Which hash functions are true permutations ?
  # 
  # It appears as though a hash function which is not a true permutation
  # will give us a bogus minhashing result.
  #
  # Given a hash function, prove through induction that it is a true
  # or false permutation.
  
  
}

hashPermuteDirect <- function(hashlist, row_count) {
  ## Which hash functions are true permutations?
  #
  # Given a hash function, prove through direct counting of choices
  # that it is a true or false permutation.
  #
  # Row count starts at 0, must provide names with hashlist

  m <- matrix(nrow=length(hashlist), ncol=2)
  rrow <- 1
  for (hf in hashlist) {
    pervec <- c()

    for (i in 0:row_count) {
      pervec <- c(pervec, hf(i))
    }
    #print(pervec)

    m[rrow, 1] <- names(hashlist)[rrow]
    m[rrow, 2] <- length(unique(pervec))

    rrow = rrow + 1
  }
  
  return(m)
}

## 3.4.2 Analysis of the Banding Technique
# 
# We can calculate the probability that these documents (or rather
# their signatures) become a candidate pair as follows:

# 1. The probability that the signatures agree in all rows of one 
#    particular band is s^r
allRows <- function(s,r) { s^r }

# 2. The probability that the signatures disagree in at least one row
#    of a particular band is 1 - s^r.
OneRowSpecBand <- function(s,r) { 1 - s^r }

# 3. The probability that the signatures disagree in at least one row
#    of each of the bands is (1 -s^r)^b.
OneRowManyBands <- function(s,r,b) { (1 - s^r)^b }

# 4. The probability that the signatures agree in all the rows of at 
#    least one band, and therefore become a candidate pair, 
#    is 1-(1-s^r)^b.
candidatePair <- function(s,r,b) { 1 - (1 - s^r)^b }


# function for computing probabilties

updateProbs <- function(s,r,b) {
  prob <- c()
  for (sProb in s) {
    prob <- c(prob, candidatePair(sProb, r, b))
  }
  return(prob)
}

oupdateProbs <- function(s,r,b) {
  prob <- c()
  for (sProb in s) {
    prob <- c(prob, OneRowManyBands(sProb, r, b))
  }
  return(prob)
}

oprobs <- function(s, rlist, blist) {
  m <- matrix(data=Inf, nrow=length(s), ncol=(length(rlist) + 1))
  m[,1] <- s

  mcol <- 2  
  count = 1
  while (count <= length(rlist)) {

    m[,mcol] <- oupdateProbs(s, rlist[[count]], blist[[count]])
    count = count + 1
    mcol = mcol + 1

  }

  colnames(m) <- append("s",names(rlist))
  return(data.frame(m))
}




