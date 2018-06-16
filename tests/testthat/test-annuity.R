context("test-annuity.R")

test_that("output from annuity computation is as expected", {

  expect_equal(round(ivt_annuity_pv(1000, 5.6, 4), 2), 3497.08)
  expect_equal(round(ivt_annuity_fv(1000, 3.4, 7), 2), 7755.86)
  expect_equal(round(ivt_annuity_due_pv(1000, 5.8, 4), 2), 3682.93)
  expect_equal(round(ivt_annuity_due_fv(1000, 7.1, 5), 2), 6171.34)
  expect_equal(round(ivt_annuity_years_pv(632.89, 10, 130)), 7)
  expect_equal(round(ivt_annuity_years_fv(762.08, 7.2, 106)), 6)
  expect_equal(round(ivt_annuity_payment_pv(610.99, 10, 7), 2), 125.50)
  expect_equal(round(ivt_annuity_payment_fv(633.53, 6.45, 5), 2), 111.38)

})
