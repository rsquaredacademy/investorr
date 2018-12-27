#' Bond price
#'
#' Computes the bond price given different inputs.
#'
#' @param face_value Face value of the bond.
#' @param coupon_rate Coupon rate of the bond.
#' @param maturity_years Years to maturity.
#' @param yield Yield to maturity.
#' @param coupon_frequency Frequency of coupon payments.
#' @param redemption_value Redemption value of the bond.
#' @param maturity_date Maturity date of the bond.
#' @param settlement_date Settlement date of the bond.
#'
#' @examples
#' ivt_bond_price_1(1000, 10, 15, 12)
#' ivt_bond_price_2(1000, 10, 15, 12, "semi-annual")
#' ivt_bond_price_3(1000, 1690, 8.2, 10.8, '2018-06-16',
#' '2019-06-16', 'annual')
#' ivt_bond_price_4(1000, 8.2, 10.8, '2018-06-16',
#' '2018-09-07')
#'
#'
#' @export
#'
ivt_bond_price_1 <- function(face_value, coupon_rate, maturity_years, yield) {

    if (coupon_rate > 1) {
        coupon_rate <- coupon_rate / 100
    }

    if (yield > 1) {
        yield <- yield / 100
    }

    coupon_payment <- face_value * coupon_rate
    discount <- 1 / ((1 + yield) ^ maturity_years)

    (coupon_payment * ((1 - discount) / yield)) + (face_value * discount)

}

#' @rdname ivt_bond_price_1
#' @export
#'
ivt_bond_price_2 <- function(face_value, coupon_rate, maturity_years, yield,
    coupon_frequency = c("annual", "semi-annual", "quarterly", "monthly")) {

    if (coupon_rate > 1) {
        coupon_rate <- coupon_rate / 100
    }

    if (yield > 1) {
        yield <- yield / 100
    }

    coupon_frequency <- match.arg(coupon_frequency)

    if (coupon_frequency == "semi-annual") {
        crate <- coupon_rate / 2
    } else if (coupon_frequency == "quarterly") {
        crate <- coupon_rate / 4
    } else if (coupon_frequency == "monthly") {
        crate <- coupon_rate / 12
    } else {
        crate <- coupon_rate
    }

    if (coupon_frequency == "semi-annual") {
        myears <- maturity_years * 2
    } else if (coupon_frequency == "quarterly") {
        myears <- maturity_years * 4
    } else if (coupon_frequency == "monthly") {
        myears <- maturity_years * 12
    } else {
        myears <- maturity_years
    }

     if (coupon_frequency == "semi-annual") {
        myield <- yield / 2
    } else if (coupon_frequency == "quarterly") {
        myield <- yield / 4
    } else if (coupon_frequency == "monthly") {
        myield <- yield / 12
    } else {
        myield <- yield
    }
   
    coupon_payment <- face_value * crate
    discount <- 1 / ((1 + myield) ^ myears)

    (coupon_payment * ((1 - discount) / myield)) + (face_value * discount)

}

#' @rdname ivt_bond_price_1
#' @export
#'
ivt_bond_price_3 <- function(face_value, redemption_value, coupon_rate, yield, settlement_date, maturity_date, 
    coupon_frequency = c("annual", "semi-annual", "quarterly")) {

    s_date <- as.Date(settlement_date)
    m_date <- as.Date(maturity_date)
    days   <- as.numeric(m_date - s_date)
    years  <- days / 365
    n      <- years

    if (coupon_frequency == "quarterly") {
        coupon_rate <- coupon_rate / 4
        yield       <- yield / 4
        n           <- n * 4
    } else if (coupon_frequency == "semi-annual") {
        coupon_rate <- coupon_rate / 2
        yield       <- yield / 2
        n           <- n * 2
    } else {
        coupon_rate <- coupon_rate
        yield       <- yield
        n           <- n
    }

    coupon_rate <- coupon_rate / 100
    yield <- yield / 100
    coupon <- face_value * coupon_rate
    dis <- (1 + yield) ^ n
    pv_par <- redemption_value / dis
    pv_coupons <- (coupon / yield)  * (1 - (1 / dis))
    pv_coupons + pv_par

}

#' @rdname ivt_bond_price_1
#' @export
#'
ivt_bond_price_4 <- function(face_value, coupon_rate, yield, settlement_date, maturity_date,
    coupon_frequency = c("annual", "semi-annual", "quarterly", "monthly")) {

    s_date <- as.Date(settlement_date)
    m_date <- as.Date(maturity_date)
    days   <- as.numeric(m_date - s_date)
    years  <- days / 360

    ivt_bond_price_2(face_value, coupon_rate, years, yield, coupon_frequency)

}

