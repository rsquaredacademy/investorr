context("test-capm.R")

test_that("output from CAPM is as expected", {

  expect_equal(
    round(
      ivt_capm_stock_return(4.4, 10.1, 0.3), 2
    ), 0.06
  )

  expect_equal(
    round(
      ivt_capm_market_return(4.4, 12.6, 2.7), 2
    ), 0.07
  )

  expect_equal(
    round(
      ivt_capm_risk_free(7.44, 12.6, 2.7), 2
    ), 0.04
  )

  expect_equal(
    round(
      ivt_capm_beta(2.1, 8.5, 12.2), 2
    ), 0.63
  )

})
