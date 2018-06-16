context("test-cf.R")

test_that("output from cash flow computation is as expected", {

  expect_equal(round(ivt_cf_fv(123.56, 8.23, 4), 2), 169.54)
  expect_equal(round(ivt_cf_pv(114.27, 6.51, 3), 2), 94.57)
  expect_equal(round(ivt_cf_stream_fv(c(100, 200, 300, 400), 7.43), 2), 1077.1)
  expect_equal(round(ivt_cf_stream_pv(c(100, 200, 300, 400), 6.62), 2), 826.78)

})
