context("test-capital-budgeting.R")

test_that("output from capital budgeting computation is as expected", {

  expect_equal(
    round(
      ivt_npv(c(-1100, 300, 200, 400, 100, 400), 9.45), 2
    ), -29.51
  )

  expect_equal(
    round(
      ivt_eaa(c(-1100, 300, 200, 400, 100, 400), 9.45), 2
    ), -7.68
  )

  expect_equal(
    round(
      ivt_profit_index(c(-1100, 300, 200, 400, 100, 400), 9.45), 2
    ), 0.97
  )

  expect_equal(
    ivt_break_even(c(-1100, 300, 200, 400, 100, 400)), 5
  )

})
