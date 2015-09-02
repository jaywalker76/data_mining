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
