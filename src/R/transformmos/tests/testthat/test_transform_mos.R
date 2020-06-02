source("../../R/transform_mos.R")

library(testthat)


context('testing transform_mos')
test_that('basic', {
  m <- c(1.1, 4, 5, 2, 3, 1.2, 4)
  c <- c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1)
  expected <- c(1.5, 5.5, 7, 3, 4, 1.5, 5.5)

  expect_equal(transform_mos(m,c), expected)
})

test_that('test fig. 3', {
  # case a
  m <- c(4, 2)
  c <- c(0.5, 0.5)
  expected <- c(2, 1)
  expect_equal(transform_mos(m,c), expected)

  # case b
  m <- c(4, 3)
  c <- c(0.6, 0.6)
  expected <- c(2, 1)
  expect_equal(transform_mos(m,c), expected)

  # case c
  m <- c(4, 3.5)
  c <- c(0.6, 0.2)
  expected <- c(1.5, 1.5)
  expect_equal(transform_mos(m,c), expected)

  # case d
  m <- c(4, 3.8, 3.3)
  c <- c(0.6, 0.6, 0.2)
  expected <- c(2.5, 2.5, 1)
  expect_equal(transform_mos(m,c), expected)

  # case e
  m <- c(4, 3.5, 3.3)
  c <- c(0.6, 0.3, 0.2)
  expected <- c(3, 1.5, 1.5)
  expect_equal(transform_mos(m,c), expected)

  # case f
  m <- c(4, 3.5, 3.3)
  c <- c(0.8, 0.4, 0.3)
  expected <- c(2, 2, 2)
  expect_equal(transform_mos(m,c), expected)

})

test_that('final test', {
  m <- c(4.49272507194938, 4.26577212950124, 4.10033767612383, 3.93832658710171,
         3.93935656976414, 3.91288674666551,3.91261926134431, 3.84816451136751,
         3.71592312027156, 3.74955202733778)
  c <- c(0.0879, 0.0984, 0.1058, 0.095, 0.1016, 0.1027, 0.1095, 0.1165, 0.0973, 0.1236)
  expected <- c(10, 9, 8, 5, 5, 5, 5, 5, 1.5, 1.5)

  expect_equal(transform_mos(m,c), expected)
})
