context("test-capital-budgeting.R")

test_that("output from capital budgeting computation is as expected", {

  myCashflow <- Cashflow$new()
  myCashflow$set_cash_flow(c(-1100, 300, 200, 400, 100, 400))
  myCashflow$set_capital_cost(9.45)

  expect_equal(round(myCashflow$compute_npv(), 2), -29.51)
  expect_equal(round(myCashflow$compute_eaa(), 2), -7.68)
  expect_equal(round(myCashflow$compute_profit_index(), 2), 0.97)
  expect_equal(myCashflow$compute_break_even(), 5)

})
