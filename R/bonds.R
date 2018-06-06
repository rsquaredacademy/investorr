#' @title Coupon dates 
#'
#' @examples
#' bond_dates("2015-05-14", "2018-10-23", 2)
#'
#' @export
#'
bond_dates <- function(sdate, mdate, freq) {
    
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
    dnc <- ncd - sdate
    dnc <- as.integer(dnc)
    
    # number of coupons
    coupons <- as.integer((mdate - pcd) / day)
    
    # coupon days
    cdays <- day
    
    result <- list(Next_Coupon_Date = ncd,
                   Previous_Coupon_Date  = pcd,
                   Coupon_Days = cdays,
                   Coupon_Days_Past = dppc,
                   Next_Coupon = dnc,
                   Coupons = coupons)
    
    return(result)
}


#' @title Bond price
#'
#' @examples
#' bond_price(1000, 1693, 5, 8, "2015-05-11", "2017-01-11", 4)
#'
#' @export
#'
bond_price <- function(par_value, redemption_value, rate, yield, settlement_date, maturity_date, frequency) {

    # compute the number of years from dates
    s_date <- as.Date(settlement_date)
    m_date <- as.Date(maturity_date)
    days <- as.numeric(m_date - s_date)
    years <- days / 365
    n <- round(years, digits = 2)

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
    coupon <- round(coupon, digits = 2)

    # compute the present value of the bond
    pv_par <- redemption_value / ((1 + yield) ^ n)

    # compute the present value of the coupons
    t <- 1
    pv_coupons <- 0

    while (t <= n) {
        pay <- coupon / ((1 + yield) ^ t)
        pv_coupons <- pv_coupons + pay
        t <- t + 1
    }

    result <- pv_coupons + pv_par
    result <- round(result, digits = 2)
    return(result)
}




bond_price_2 <- function(par_value, redemption_value, rate, yield, settlement_date, maturity_date, frequency) {
    
    # compute the number of years from dates
    s_date <- as.Date(settlement_date)
    m_date <- as.Date(maturity_date)
    days <- as.numeric(m_date - s_date)
    years <- days / 365
    n <- round(years, digits = 2)
    
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
    coupon <- round(coupon, digits = 2)
    
    # discount
    dis <- (1 + yield) ^ n
    
    # compute the present value of the bond
    pv_par <- redemption_value / dis
    
    # compute the present value of the coupons
    pv_coupons <- (coupon / yield)  * (1 - (1 / dis))
    
    result <- pv_coupons + pv_par
    result <- round(result, digits = 2)
    return(result)
}

bond_price_2(1000, 1693, 5, 8, "2015-05-11", "2017-01-11", 4)


#' @title Current yield
#'
#' @examples
#' current_yield(100, 10, 95.92) 
#'
#' @export
#'
current_yield <- function(par_value, rate, price) {

    # transform the rate
    rate <- rate / 100

    # compute the coupon payment
    coupon <- par_value * rate
    coupon <- round(coupon, digits = 2)

    # compute the current yield
    current_yield <- coupon / price
    current_yield <- current_yield * 100
    current_yield <- round(current_yield, digits = 2)

    return(current_yield)
}


#' @title Adjusted current yield
#'
#' @examples
#' adjusted_current_yield(100, 5, 95.92, 2.5)
#'
#' @export
#'
adjusted_current_yield <- function(par_value, rate, price, n) {

    # transform the rate
    rate <- rate / 100

    # compute the coupon payment
    coupon <- par_value * rate
    coupon <- round(coupon, digits = 2)

    # compute the current yield
    current_yield <- coupon / price
    current_yield <- current_yield * 100
    price_diff <- (par_value - price) / n
    adjusted_current_yield <- current_yield + price_diff
    adjusted_current_yield <- round(adjusted_current_yield, digits = 2)
    return(adjusted_current_yield)
}




#' @title Cash flow
#'
#' @export
#'
cash_flow <- function(M, r) {
    
    # cash flow
    cash <- M * r
    cash <- round(cash, digits = 2)
}

#' @title Bond price
#'
#' @examples
#' bprice(1000, 5, 4, 5, 1)
#'
#' @export
#'
bprice <- function(par_value, rate, yield, n, frequency) {
    
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
    coupon <- round(coupon, digits = 2)
    
    # discount
    dis <- (1 + yield) ^ n
    
    # compute the present value of the bond
    pv_par <- par_value / dis
    
    # compute the present value of the coupons
    pv_coupons <- (coupon / yield)  * (1 - (1 / dis))
    
    result <- pv_coupons + pv_par
    result <- round(result, digits = 2)
    return(result)
}


#' @title Macaulay duration
#'
#' @examples
#' macaulay_duration(8, 9, 5, 1000, 4)
#'
#' @export
#'
macaulay_duration <- function(rate, yield, n, par_value, freq) {
    
    # transform rate
    yield <- yield / 100
    rate <- rate / 100
    
    if (freq == 4) {
        rate <- rate / 4
        n <- n * 4
        yield <- yield / 4
    } else if (freq == 2) {
        rate <- rate / 2
        n <- n * 2
        yield <- yield / 2
    } else {
        rate <- rate
        n <- n
        yield <- yield
    }
    
    # compute cash flow
    C <- cash_flow(par_value, rate)
    
    # compute bond price
    p <- bprice(par_value, rate, yield, n, freq)
    
    # second part
    nm <- n * par_value / ((1 + yield) ^ n)
    
    # summation
    t <- 1
    sum <- 0
    while (t <= n) {
        sim <- (t * C) / ((1 + yield) ^ t)
        sum <- sum + sim
        t <- t + 1
    }
    
    macaulay <- (sum + nm) / p
    macaulay <- round(macaulay, digits = 2)
    return(macaulay)
}


#' @title Bond duration
#'
#' @examples
#' duration(1000, 6, 4, 5, 2)
#'
#' @export
#'
duration <- function(par_value, rate, yield, n) {
    
    # transform rate
    yield <- yield / 100
    rate <- rate / 100

    # compute coupon
    coupon <- cash_flow(par_value, rate)
    
    # compute price
    # compute bond price
    price <- bprice(par_value, rate, yield, n, freq)
    
    t <- 1
    n1 <- n - freq
    dur1 <- 0
    
    
    while (t <= n1) {
        dur <- ((coupon / (( 1 + yield) ^ t)) / price) * t
        dur1 <- dur1 + dur
        t <- t + 1
    }
    
    dur2 <- (((par_value + coupon) / ((1 + yield) ^ n)) / price) * n
    
    years <- round((dur1 + dur2), 2)
    
    result <- list(coupon, price, dur1, dur2, years)
    
    return(result)
}



#' @title Bond price
#'
#' @export
#'
bond_price <- function(r, i, n, M) {
    
    C <- cash_flow(M, r)
    ni <- (1 + i) ^ n
    price <- C * ((1 - (1 / ni)) / i) + (M / ni)
    price <- round(price, digits = 2)
    return(price)
}


#' @title Macaulay duration
#'
#' @examples
#' macaulay_duration(8, 9, 5, 1000)
#'
#' @export
#'
macaulay_duration <- function(r, i, n, M) {
    
    # transform rate
    i <- i / 100
    r <- r / 100
    
    # compute cash flow
    C <- cash_flow(M, r)
    
    # compute bond price
    p <- bond_price(r, i, n, M)
    
    # second part
    nm <- n * M / ((1 + i) ^ n)
    
    # summation
    t <- 1
    sum <- 0
    while (t < 6) {
        sim <- (t * C) / ((1 + i) ^ t)
        sum <- sum + sim
        t <- t + 1
    }
    
    macaulay <- (sum + nm) / p
    macaulay <- round(macaulay, digits = 2)
    return(macaulay)
}

#' @title Yield to maturity
#'
#' @examples
#' yield_to_maturity(1000, 10, 920, 10, 2)
#'
#' @export
#'
yield_to_maturity <- function(par_value, rate, price, n, freq) {
    
    # transform rate
    rate <- rate / 100
    
    # annual, semi-annual, quarterly computations
    if (freq == 4) {
        rate <- rate / 4
        n <- n * 4
    } else if (freq == 2) {
        rate <- rate / 2
        n <- n * 2
    } else {
        rate <- rate 
        n <- n
    }

    # compute coupon payment
    coupon <- par_value * rate

    # compute yield to maturity
    ytm <- (coupon + (par_value - price) / n) / ((par_value + price) / 2)
    ytm <- ytm * 100
    ytm <- round(ytm, digits = 2)
    return(ytm)
}



yield_to_maturity_2 <- function(par_value, rate, price, n, freq) {

    # transform rate
    rate <- rate / 100
    
    # annual, semi-annual, quarterly computations
    if (freq == 4) {
        rate <- rate / 4
        n <- n * 4
    } else if (freq == 2) {
        rate <- rate / 2
        n <- n * 2
    } else {
        rate <- rate 
        n <- n
    }

    # compute coupon payment
    coupon <- par_value * rate

    # discount
    discount <- par_value - price

    # annualized capital gains
    acg <- discount / n

    # annualized returns
    ar <- acg + coupon

    # yield A
    yield_a <- ar / price

    # yield B
    yield_b <- ar / (par_value - acg)

    # result
    ytm <- (yield_a + yield_b) / 2
    ytm <- ytm * 100
    ytm <- round(ytm, digits = 2)

    return(ytm)
}

yield_to_maturity_2(1000, 10, 920, 10, 2)






































