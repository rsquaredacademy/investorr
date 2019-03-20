context("test-annuity.R")

test_that("output from annuity computation is as expected", {

	myAnnuity <- Annuity$new()
	myAnnuity$set_payment(1000)
	myAnnuity$set_rate(5.6)
	myAnnuity$set_years(4)
	expect_equal(round(myAnnuity$compute_pv(), 2), 3497.08)

	myAnnuity <- Annuity$new()
	myAnnuity$set_payment(1000)
	myAnnuity$set_rate(3.4)
	myAnnuity$set_years(7)
  expect_equal(round(myAnnuity$compute_fv(), 2), 7755.86)

  myAnnuity <- Annuity$new()
	myAnnuity$set_payment(1000)
	myAnnuity$set_rate(5.8)
	myAnnuity$set_years(4)
  expect_equal(round(myAnnuity$compute_pv_due(), 2), 3682.93)

  myAnnuity <- Annuity$new()
	myAnnuity$set_payment(1000)
	myAnnuity$set_rate(7.1)
	myAnnuity$set_years(5)
  expect_equal(round(myAnnuity$compute_fv_due(), 2), 6171.34)

  myAnnuity <- Annuity$new()
	myAnnuity$set_payment(130)
	myAnnuity$set_rate(10)
	myAnnuity$set_pv(632.89)
  expect_equal(round(myAnnuity$compute_years()), 7)

  myAnnuity <- Annuity$new()
	myAnnuity$set_payment(106)
	myAnnuity$set_rate(7.2)
	myAnnuity$set_fv(762.08)
  expect_equal(round(myAnnuity$compute_years(pv = FALSE)), 6)

  myAnnuity <- Annuity$new()
	myAnnuity$set_years(7)
	myAnnuity$set_rate(10)
	myAnnuity$set_pv(610.99)
  expect_equal(round(myAnnuity$compute_payment(), 2), 125.50)

  myAnnuity <- Annuity$new()
	myAnnuity$set_years(5)
	myAnnuity$set_rate(6.45)
	myAnnuity$set_fv(633.53)
  expect_equal(round(myAnnuity$compute_payment(pv = FALSE), 2), 111.38)

})
