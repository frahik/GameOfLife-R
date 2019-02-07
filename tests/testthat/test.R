library(testthat)
library(GameOfLife)

context('Play')
test_that('Non interactive', {
  GOF <- game_of_life(interactive = FALSE)
  expect_output(str(GOF), 'List of 4')
  expect_is(GOF$simulation, 'array')
  expect_is(GOF$simulation[,,1], 'matrix')
})
