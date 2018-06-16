context("test-others.R")

test_that("output from risk and return computation is as expected", {

  stock_return <- ivt_stock_risk_return(c(20, 25, 30, 25), c(10, 21, 5, -17))

  expect_equal(
    round(
      stock_return$expected_return, 3
    ), 0.045
  )

  expect_equal(
    round(
      stock_return$variance, 3
    ), 0.019
  )

  expect_equal(
    round(
      stock_return$std_deviation, 3
    ), 0.138
  )

  pf_return <- ivt_pf_risk_return(c(30, 15, 30, 25), c(34, 18, -2, 34),
                                         c(-7, 3, 15, 8),
                                        correlation = 1, weight_1 = 0.5)

  expect_equal(
    round(
      pf_return$portfolio_return, 3
    ), 0.128
  )

  expect_equal(
    round(
      pf_return$portfolio_var, 3
    ), 0.015
  )

  expect_equal(
    round(
      pf_return$portfolio_sd, 3
    ), 0.123
  )

})


test_that('output from stock valuation is as expected', {

  expect_equal(
    round(ivt_stock_price(1.39, 1.51, 4.65), 2), 44.27
  )

  expect_equal(
    round(ivt_stock_dividend(248.64, 3.21, 5.41), 2), 5.47
  )

  expect_equal(
    round(ivt_stock_growth(50.77, 3.76, 13.27), 2), 5.86
  )

  expect_equal(
    round(ivt_stock_return(48.77, 3.88, 8.1), 2), 16.06
  )

  expect_equal(
    round(
      ivt_stock_ncg_price(3.89, 14.3, c(4, 11, 7, 8, 7)), 2
    ), 57.8
  )
})
