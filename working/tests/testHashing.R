setwd("..")
source("hashing.R")

context("Minhash Algorithm")

test_that("hash functions return correct values", {
  expect_that(h1(0), equals(1))
  expect_equal(h1(1), 2)
  expect_equal(h2(1), 4)
  expect_equal(h1(2), 3)
  expect_equal(h2(2), 2)
  expect_equal(h1(3), 4)
  expect_equal(h2(3), 0)
  expect_equal(h1(4), 0)
  expect_equal(h2(4), 3)
})

s1 <- unique(c("a","d"))
s2 <- unique(c("c"))
s3 <- unique(c("b","d","e"))
s4 <- unique(c("a","c", "d"))
setList <- list(s1,s2,s3,s4)

test_that("figures from ch.3 can be computed", {
  expect_true(setsToMatrix(setList)[1,1] == "a")
  expect_true(setsToMatrix(setList)[5,4] == "1")
})


# Figure 3.4: Hash functions computed for the matrix of Fig. 3.2
s1 <- c(0,3); s2 <- c(2); s3 <- c(1,3,4); s4 <- c(0,2,3)
x <- c(1,2,3,4,0); threex <- c(1,4,2,0,3)

# use a matrix as it looks in the book; figure 3.2
setList <- list(s1,s2,s3,s4)
fig_3.2 <- setsToMatrix(setList)
colnames(fig_3.2) <- c("row", "s1", "s2", "s3","s4")


test_that("Minhash signatures match Example 3.8 in ch. 3", {
  demo <- computeDemoMinhashSigs(h1, h2, fig_3.2)
  expect_true(demo[1,2] == 1)
  expect_true(demo[1,3] == 3)
  expect_true(demo[1,4] == 0)
  expect_true(demo[1,5] == 1)
  expect_true(demo[2,2] == 0)
  expect_true(demo[2,3] == 2)
  expect_true(demo[2,4] == 0)
  expect_true(demo[2,5] == 0)
})

# testing minhash signature update
colint <- c(0,0,0,1,1)
m <- matrix(data=Inf, nrow=2, ncol=5)
hash <- h1; rrow <- 1; jrow <- 0

test_that("Minhash signature is correctly updated", {
  demo <- updateMinhashSig(m,colint,hash,rrow,jrow)
  
  # updates when was Inf
  expect_true(demo[1,4] == 1)
  expect_true(demo[1,5] == 1)
  
  # updates when hash < previous hash
  jrow <- 4
  demo <- updateMinhashSig(demo,colint,hash,rrow,jrow)

  expect_true(demo[1,4] == 0)
  expect_true(demo[1,5] == 0)
  
})

## testing Minhash signature computation
s1 <- c(0,3); s2 <- c(2); s3 <- c(1,3,4); s4 <- c(0,2,3)
hashlist <- list(h1,h2); setlist <- list(s1,s2,s3,s4)

test_that("Minhash signature is computed correctly", {
  demo <- computeMinhashSigs(hashlist, setlist)

  # Is output identical to Example 3.8 (p. 84)?

  # h1
  expect_true(demo[1,1] == 1)
  expect_true(demo[1,2] == 3)
  expect_true(demo[1,3] == 0)
  expect_true(demo[1,4] == 1)

  # h2
  expect_true(demo[2,1] == 0)
  expect_true(demo[2,2] == 2)
  expect_true(demo[2,3] == 0)
  expect_true(demo[2,4] == 0)
})

## testing true permutations of hash functions can be proven by 
## directly counting the permutations.

h1 <- function(x) { (2*x + 1) %% 6 }
h2 <- function(x) { (3*x + 2) %% 6 }
h3 <- function(x) { (5*x + 2) %% 6 }
s1 <- c(2,5); s2 <- c(0,1); s3 <- c(3,4); s4 <- c(0,2,4)

hashlist <- list("h1"=h1,"h2"=h2,"h3"=h3)
row_count <- 6


test_that("Hash functions are true or false permutations with direct", {
  demo <- hashPermuteDirect(hashlist, row_count)

  # false
  expect_false(demo[1,2] == "6") # h1
  expect_false(demo[2,2] == "6") # h2
  # true 
  expect_true(demo[3,2] == "6") # h3
  # check names for sanity
  expect_true(demo[3,1] == "h3")
})
  

context("LSH Algorithm")

test_that("Candidate pair probabilities are correct", {
  expect_equal(round(candidatePair(s=0.2,r=5,b=20),3),0.006)
  expect_equal(round(candidatePair(s=0.3,r=5,b=20),3),0.047)
  expect_equal(round(candidatePair(s=0.4,r=5,b=20),3),0.186)
})


test_that("Candidate pair probabilities are updated correctly", {
  s <- c(0.2,0.3,0.4); r <- 5; b <- 20
  expect_equal(round(updateProbs(s,r,b),3), c(0.006,0.047,0.186))
})

test_that("Candidate pair probabilities calculated as matrix", {
  s <- c(0.2,0.3,0.4); rlist <- list("r5b20"=5,"r3b10"=3,"r6b20"=6)
  blist <- list(20,10,20)
  expect_equal(round(probs(s,rlist,blist)[,2],3),
               c(0.006,0.047,0.186))
})
