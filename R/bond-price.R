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
#' '2019-06-16', 1)
#' ivt_bond_price_4(1000, 8.2, 10.8, '2018-06-16',
#' '2018-09-07')
#'
#' @importFrom magrittr %<>% divide_by
#' @importFrom dplyr case_when
#'
#' @export
#'
ivt_bond_price_1 <- function(face_value, coupon_rate, maturity_years, yield) {

    if (coupon_rate > 1) {
        coupon_rate %<>% divide_by(100)
    }

    if (yield > 1) {
        yield %<>% divide_by(100)
    }

    coupon_payment <- face_value * coupon_rate
    discount <- 1 / ((1 + yield) ^ maturity_years)

    (coupon_payment * ((1 - discount) / yield)) + (face_value * discount)

}

#' @importFrom dplyr case_when
#' @rdname ivt_bond_price_1
#' @export
#'
ivt_bond_price_2 <- function(face_value, coupon_rate, maturity_years, yield,
    coupon_frequency = c("annual", "semi-annual", "quarterly", "monthly")) {

    if (coupon_rate > 1) {
        coupon_rate %<>% divide_by(100)
    }

    if (yield > 1) {
        yield %<>% divide_by(100)
    }

    coupon_frequency <- match.arg(coupon_frequency)

    crate <-
        case_when(
            coupon_frequency == "semi-annual" ~ coupon_rate / 2,
            coupon_frequency == "quarterly" ~ coupon_rate / 4,
            coupon_frequency == "monthly" ~ coupon_rate / 12,
            TRUE ~ coupon_rate

        )

    myears <-
        case_when(
            coupon_frequency == "semi-annual" ~ maturity_years * 2,
            coupon_frequency == "quarterly" ~ maturity_years  * 4,
            coupon_frequency == "monthly" ~ maturity_years * 12,
            TRUE ~ maturity_years

        )

    myield <-
        case_when(
            coupon_frequency == "semi-annual" ~ yield / 2,
            coupon_frequency == "quarterly" ~ yield / 4,
            coupon_frequency == "monthly" ~ yield / 12,
            TRUE ~ yield

        )

    coupon_payment <- face_value * crate
    discount <- 1 / ((1 + myield) ^ myears)

    (coupon_payment * ((1 - discount) / myield)) + (face_value * discount)

}

#' @rdname ivt_bond_price_1
#' @export
#'
ivt_bond_price_3 <- function(face_value, redemption_value, coupon_rate, yield, settlement_date, maturity_date, 
    coupon_frequency = c("annual", "semi-annual", "quarterly")) {

    # compute the number of years from dates
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

    # transform the rates
    coupon_rate <- coupon_rate / 100
    yield <- yield / 100

    # compute the coupon payments
    coupon <- face_value * coupon_rate

    # discount
    dis <- (1 + yield) ^ n

    # compute the present value of the bond
    pv_par <- redemption_value / dis

    # compute the present value of the coupons
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

