source("../../R/transform_mos.R")

library(testthat)


context('testing transform_mos')
test_that('basic', {
  mos <- c(1.1, 4, 5, 2, 3, 1.2, 4)
  ci <- c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1)
  expected <- c(1.5, 5.5, 7, 3, 4, 1.5, 5.5)

  expect_equal(transform_mos(mos,ci), expected)
})

test_that('test fig. 3', {
  # case a
  mos <- c(4, 2)
  ci <- c(0.5, 0.5)
  expected <- c(2, 1)
  expect_equal(transform_mos(mos,ci), expected)

  # case b
  mos <- c(4, 3)
  ci <- c(0.6, 0.6)
  expected <- c(2, 1)
  expect_equal(transform_mos(mos,ci), expected)

  # case c
  mos <- c(4, 3.5)
  ci <- c(0.6, 0.2)
  expected <- c(1.5, 1.5)
  expect_equal(transform_mos(mos,ci), expected)

  # case d
  mos <- c(4, 3.8, 3.3)
  ci <- c(0.6, 0.6, 0.2)
  expected <- c(2.5, 2.5, 1)
  expect_equal(transform_mos(mos,ci), expected)

  # case e
  mos <- c(4, 3.5, 3.3)
  ci <- c(0.6, 0.3, 0.2)
  expected <- c(3, 1.5, 1.5)
  expect_equal(transform_mos(mos, ci), expected)

  # case f
  mos <- c(4, 3.5, 3.3)
  ci <- c(0.8, 0.4, 0.3)
  expected <- c(2, 2, 2)
  expect_equal(transform_mos(mos,ci), expected)

})

test_that('final test', {
  mos <- c(4.493, 4.266, 4.1, 3.938, 3.939, 3.913,3.917, 3.848,
         3.716, 3.749)
  ci <- c(0.0879, 0.0984, 0.1058, 0.095, 0.1016, 0.1027, 0.1095, 0.1165, 0.0973, 0.1236)
  expected <- c(10, 9, 8, 5, 5, 5, 5, 5, 1.5, 1.5)

  expect_equal(transform_mos(mos,ci), expected)
})
