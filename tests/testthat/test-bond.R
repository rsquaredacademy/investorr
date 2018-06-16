context("test-bond.R")

test_that("output from bond price computation as expected", {

  expect_equal(round(ivt_bond_price_1(1000, 8.5, 20, 11.23), 2), 785.83)
  expect_equal(
    round(ivt_bond_price_2(1000, 8.5, 20, 11.23, "semi-annual"), 2),
    784.24)
  expect_equal(
    round(ivt_bond_price_2(1000, 8.5, 20, 11.23, "quarterly"), 2),
    783.43)
  expect_equal(
    round(ivt_bond_price_2(1000, 8.5, 20, 11.23, "monthly"), 2),
    782.9)
  expect_equal(
    round(
      ivt_bond_price_3(1000, 1690, 8.2, 10.8, '2018-06-16',
                       '2019-06-16', 2), 2
    ),
    1597.07
  )
  expect_equal(
    round(
      ivt_bond_price_3(1000, 1690, 8.2, 10.8, '2018-06-16',
                       '2019-06-16', 4), 2
    ),
    1595.92
  )
  expect_equal(
    round(
      ivt_bond_price_4(1000, 8.2, 10.8, '2018-06-16',
                       '2018-09-07', 'semi-annual'), 2
    ),
    994.23
  )
  expect_equal(
    round(
      ivt_bond_price_4(1000, 8.2, 10.8, '2018-06-16',
                       '2018-09-07', 'quarterly'), 2
    ),
    994.16
  )
  expect_equal(
    round(
      ivt_bond_price_4(1000, 8.2, 10.8, '2018-06-16',
                       '2018-09-07', 'monthly'), 2
    ),
    994.11
  )
  expect_equal(
    round(
      ivt_bond_price_4(1000, 8.2, 10.8, '2018-06-16',
                       '2018-09-07', 'monthly'), 2
    ),
    994.11
  )
  expect_equal(
    round(
      ivt_bond_ytm(1000, 10, 862.35, 15), 2
    ),
    12.02
  )
  expect_equal(
    round(
      ivt_cyield(1000, 8.6, 987), 2
    ),
    8.71
  )
  expect_equal(
    round(
      ivt_adj_cyield(100, 5, 95.92, 2.5), 2
    ),
    6.84
  )
  expect_equal(
    round(
      ivt_duration_macaulay(1000, 8.67, 12.43, 3), 2
    ),
    2.76
  )
  expect_equal(
    round(
      ivt_duration_modified(1000, 8.67, 12.43, 3), 2
    ),
    2.45
  )
  expect_equal(
    round(
      ivt_bond_convexity(100, 10.47, 12.36, 6), 2
    ),
    23.77
  )
})
