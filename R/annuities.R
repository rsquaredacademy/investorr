#' @title Present value of annuity
#'
#' @examples 
#' annuity_pv(500000, 8, 5)
#'
#' @export
#'
annuity_pv <- function(payment, rate, periods) {
    
    # transform the rate
    rate <- rate / 100
    
    # compute perpetuity
    perpetuity <- 1 / rate
    
    # compute discounting
    discount <- 1 / (rate * ((1 + rate) ^ periods))
    
    # present value
    pv <- payment * (perpetuity -  discount)
    pv <- round(pv, digits = 2)
    return(pv)
}


#' @title Future value of annuity
#'
#' @examples
#' annuity_fv(1000, 6, 5)
#'
#' @export
#'
annuity_fv <- function(payment , rate, periods) {
    
    # transform the rate
    rate <- rate / 100
     
    # compute discount
    discount <- (1 + rate) ^ periods
    
    # future value
    fv <- payment * ((discount - 1) / rate)
    fv <- round(fv, digits = 2)
    return(fv)
}



#' @title Present value of annuity due
#'
#' @examples
#' annuity_due_pv(1000, 5, 5)
#'
#' @export
#'
annuity_due_pv <- function(payment, rate, periods) {
    
    p_annuity <- pv_annuity(payment, rate, periods)
    p_an_due <- p_annuity * (1 + (rate / 100))
    p_an_due <- round(p_an_due, digits = 2)
    return(p_an_due)
}


#' @title Future value of annuity due
#'
#' @examples
#' annuity_due_fv(1000, 5, 5)
#'
#' @export
#'
fv_annuity_due <- function(payment, rate, periods) {
    
    f_annuity <- fv_annuity(payment, rate, periods)
    f_an_due <- f_annuity * (1 + (rate / 100))
    f_an_due <- round(f_an_due, digits = 2)
    return(f_an_due)
}


#' @title Payments FV
#'
#' @export
#'
payment_fv <- function(future_value, rate, periods) {
    
    # transform rate
    rate <- rate / 100
    
    # compute payment
    payment <- (rate * future_value) / (((1 + rate) ^ periods) - 1)
    payment <- round(payment, digits = 2)
    return(payment)
}

#' @title Payments PV
#'
#' @export
#'
payment_pv <- function(present_value, rate, periods) {
    
    # transform rate
    rate <- rate / 100
    
    # compute payment
    payment <- (rate * present_value) / (1 - ((1 + rate) ^ -periods))
    payment <- round(payment, digits = 2)
    return(payment)
}

#' @title Periods FV
#'
#' @examples
#' periods_fv(500, 8, 50)
#'
#' @export
#'
periods_fv <- function(future_value, rate, payment) {
    
    # transform rate
    rate <- rate / 100
    
    periods <- log(((rate * future_value) / payment) + 1) / log(1 + rate)
    periods <- round(periods, digits = 2)
    return(periods)
}


#' @title Periods PV
#'
#' @examples
#' periods_pv(500, 8, 50)
#'
#' @export
#'
periods_pv <- function(present_value, rate, payment) {
    
    # transform rate
    rate <- rate / 100
    
    periods <- - (log(1 - ((rate * present_value) / payment)) / log ( 1 + rate))
    periods <- round(periods, digits = 2)
    return(periods)
}

















