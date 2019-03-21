context("test-cf.R")

test_that("output from cash flow computation is as expected", {

	myCashflow <- Cashflow$new()
	myCashflow$set_cash_flow(123.56)
	myCashflow$set_interest_rate(8.23)
	myCashflow$set_years(4)
  expect_equal(round(myCashflow$compute_fv(), 2), 169.54)

  myCashflow <- Cashflow$new()
	myCashflow$set_cash_flow(114.27)
	myCashflow$set_discount_rate(6.51)
	myCashflow$set_years(3)
  expect_equal(round(myCashflow$compute_pv(), 2), 94.57)

  myCashflow <- Cashflow$new()
	myCashflow$set_cf_stream(c(100, 200, 300, 400))
	myCashflow$set_interest_rate(7.43)
  expect_equal(round(myCashflow$compute_fv_stream(), 2), 1077.1)

  myCashflow <- Cashflow$new()
	myCashflow$set_cf_stream(c(100, 200, 300, 400))
	myCashflow$set_discount_rate(6.62)
  expect_equal(round(myCashflow$compute_pv_stream(), 2), 826.78)

})
