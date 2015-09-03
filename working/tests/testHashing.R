setwd("..")
source("hashing.R")

context("Hashing algorithms")

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
