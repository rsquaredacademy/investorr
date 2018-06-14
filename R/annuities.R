#' Annuity
#'
#' Computes present value, future value, payments and periods
#' for annuity and annuity due.
#'
#' @param payment Annuity payment.
#' @param interest_rate Interest rate.
#' @param discount Discount rate. 
#' @param years Number of years/annuity payments.
#' @param future_value Future value of cash flow.
#' @param present_value Present value of cash flow.
#'
#' @examples
#' # present value of annuity
#' ivt_annuity_pv(500000, 8, 5)
#'
#' # future value of annuity
#' ivt_annuity_fv()
#'
#' # present value of annuity due
#' ivt_annuity_due_pv()
#'
#' # future value of annuity due
#' ivt_annuity_due_fv()
#'
#' # payments given present value
#' ivt_payment_pv()
#'
#' # payments given future value
#' ivt_payment_fv()
#'
#' # years given present value
#' ivt_years_pv()
#'
#' # years given future value
#' ivt_years_fv()
#'
#' @export
#'
ivt_annuity_pv <- function(payment, rate, periods) {

    rate       <- rate / 100
    perpetuity <- 1 / rate
    discount   <- 1 / (rate * ((1 + rate) ^ periods))
    payment * (perpetuity -  discount)

}


#' @rdname ivt_annuity_pv
#' @export
#'
ivt_annuity_fv <- function(payment , rate, periods) {

    rate     <- rate / 100
    discount <- (1 + rate) ^ periods
    payment * ((discount - 1) / rate)

}



#' @rdname ivt_annuity_pv
#' @export
#'
ivt_annuity_due_pv <- function(payment, rate, periods) {

    p_annuity <- pv_annuity(payment, rate, periods)
    p_annuity * (1 + (rate / 100))

}


#' @rdname ivt_annuity_pv
#' @export
#'
ivt_annuity_due_fv <- function(payment, rate, periods) {

    f_annuity <- fv_annuity(payment, rate, periods)
    f_annuity * (1 + (rate / 100))

}


#' @rdname ivt_annuity_pv
#' @export
#'
ivt_payment_fv <- function(future_value, rate, periods) {

    rate <- rate / 100
    (rate * future_value) / (((1 + rate) ^ periods) - 1)

}

#' @rdname ivt_annuity_pv
#' @export
#'
ivt_payment_pv <- function(present_value, rate, periods) {

    rate <- rate / 100
    (rate * present_value) / (1 - ((1 + rate) ^ -periods))

}

#' @rdname ivt_annuity_pv
#' @export
#'
ivt_years_fv <- function(future_value, rate, payment) {

    rate <- rate / 100
    log(((rate * future_value) / payment) + 1) / log(1 + rate)

}


#' @rdname ivt_annuity_pv
#' @export
#'
ivt_years_pv <- function(present_value, rate, payment) {

    rate <- rate / 100
    - (log(1 - ((rate * present_value) / payment)) / log ( 1 + rate))

}

















