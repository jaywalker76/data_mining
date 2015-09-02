setwd("..")
source("similarity.R")

context("Similarity algorithms")

s1 <- c(1,2,3)
s2 <- c(3,4,5)
s3 <- c(4,5,6)

test_that("Jaccard similarity is computed correctly", {
  expect_equal(jaccard(s1,s2), 0.2)
  expect_equal(jaccard(s2,s3), 0.5)
})
