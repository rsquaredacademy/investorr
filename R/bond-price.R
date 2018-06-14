#' Bond price
#'
#' Computes the bond price given different inputs.
#'
#' @param face_value Face value of the bond.
#' @param coupon_rate Coupon rate of the bond.
#' @param maturity_years Years to maturity.
#' @param yield Yield to maturity.
#' @param coupon_frequency Frequency of coupon payments.
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
ivt_bond_price_2 <- function(face_value, coupon_rate, maturity_years, yield, coupon_frequency = c("annual", "semi-annual", "quarterly", "monthly")) {

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
            TRUE ~ maturity_years

        )

    coupon_payment <- face_value * crate
    discount <- 1 / ((1 + myield) ^ myears)

    (coupon_payment * ((1 - discount) / myield)) + (face_value * discount)

}

#' @rdname ivt_bond_price_1
#' @export
#'
ivt_bond_price_3 <- function(par_value, redemption_value, rate, yield, settlement_date, maturity_date, frequency) {

    # compute the number of years from dates
    s_date <- as.Date(settlement_date)
    m_date <- as.Date(maturity_date)
    days   <- as.numeric(m_date - s_date)
    years  <- days / 365
    n      <- years

    if (frequency == 4) {
        rate <- rate / 4
        yield <- yield / 4
        n <- n * 4
    } else if (frequency == 2) {
        rate <- rate / 2
        yield <- yield / 2
        n <- n * 2
    } else {
        rate <- rate
        yield <- yield
        n <- n
    }

    # transform the rates
    rate <- rate / 100
    yield <- yield / 100

    # compute the coupon payments
    coupon <- par_value * rate

    # discount
    dis <- (1 + yield) ^ n

    # compute the present value of the bond
    pv_par <- redemption_value / dis

    # compute the present value of the coupons
    pv_coupons <- (coupon / yield)  * (1 - (1 / dis))

    result <- pv_coupons + pv_par
    return(result)
}

#' @rdname ivt_bond_price_1
#' @export
#'
ivt_bond_price_4 <- function(par_value, rate, yield, settlement_date, maturity_date, frequency) {

    ivt_bond_price_3(par_value, par_value, rate, yield, settlement_date,
                     maturity_date, frequency)

}

#' @rdname ivt_bond_price_1
#' @export
#'
ivt_bond_dates <- function(sdate, mdate, freq) {

    # convert sdate and mdate to date type
    sdate <- as.Date(sdate)
    mdate <- as.Date(mdate)

    # frequency settings
    if (freq == 1) {
        day <- 360
        month1 <- 12
    } else if (freq == 2) {
        day <- 180
        month1 <- 6
    } else {
        day <- 90
        month1 <- 3
    }

    # compute months and years
    month <- (mdate - sdate) / 30
    month <- as.integer(floor(month))

    year <- month / 12
    year <- ceiling(year)

    # compute the days
    bond_start_date <- mdate - years(year)
    days_past_start <- sdate - bond_start_date
    payments_passed <- days_past_start / day
    payments_passed <- ceiling(payments_passed)
    payments_passed <- as.integer(payments_passed * month1)

    # next coupon date
    ncd <- bond_start_date + months(payments_passed)

    # previous coupon date
    pcd <- ncd - months(month1)

    # days past previous coupon
    dppc <- sdate - pcd
    dppc <- as.integer(dppc)

    # days before next coupon
    dnc <- ncd - sdate - 1
    dnc <- as.integer(dnc)

    # number of coupons
    coupons <- as.integer((mdate - pcd) / day)

    # coupon days
    cdays <- day

    result <- list(next_coupon_date = ncd,
                   previous_coupon_date  = pcd,
                   coupon_days = cdays,
                   days_past_previous_coupon = dppc,
                   days_before_next_coupon = dnc,
                   coupons = coupons)

    return(result)
}


