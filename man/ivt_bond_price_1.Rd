% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bond-price.R
\name{ivt_bond_price_1}
\alias{ivt_bond_price_1}
\alias{ivt_bond_price_2}
\alias{ivt_bond_price_3}
\alias{ivt_bond_price_4}
\title{Bond price}
\usage{
ivt_bond_price_1(face_value, coupon_rate, maturity_years, yield)

ivt_bond_price_2(face_value, coupon_rate, maturity_years, yield,
  coupon_frequency = c("annual", "semi-annual", "quarterly", "monthly"))

ivt_bond_price_3(face_value, redemption_value, coupon_rate, yield,
  settlement_date, maturity_date, coupon_frequency = c("annual",
  "semi-annual", "quarterly"))

ivt_bond_price_4(face_value, coupon_rate, yield, settlement_date,
  maturity_date, coupon_frequency = c("annual", "semi-annual",
  "quarterly", "monthly"))
}
\arguments{
\item{face_value}{Face value of the bond.}

\item{coupon_rate}{Coupon rate of the bond.}

\item{maturity_years}{Years to maturity.}

\item{yield}{Yield to maturity.}

\item{coupon_frequency}{Frequency of coupon payments.}

\item{redemption_value}{Redemption value of the bond.}

\item{settlement_date}{Settlement date of the bond.}

\item{maturity_date}{Maturity date of the bond.}
}
\description{
Computes the bond price given different inputs.
}
\examples{
ivt_bond_price_1(1000, 10, 15, 12)
ivt_bond_price_2(1000, 10, 15, 12, "semi-annual")
ivt_bond_price_3(1000, 1690, 8.2, 10.8, '2018-06-16',
'2019-06-16', 'annual')
ivt_bond_price_4(1000, 8.2, 10.8, '2018-06-16',
'2018-09-07')


}
