#' Annuity
#'
#' Computes present value, future value, payments and years
#' for annuity and annuity due.
#'
#' @param payment Annuity payment.
#' @param rate Interest/discount rate.
#' @param years Number of years/annuity payments.
#' @param future_value Future value of cash flow.
#' @param present_value Present value of cash flow.
#'
#' @examples
#' # present value of annuity
#' ivt_annuity_pv(1000, 8, 5)
#'
#' # future value of annuity
#' ivt_annuity_fv(950, 7.3, 6)
#'
#' # present value of annuity due
#' ivt_annuity_due_pv(1000, 4.8, 5)
#'
#' # future value of annuity due
#' ivt_annuity_due_fv(1000, 6.4, 3)
#'
#' # payments given present value
#' ivt_annuity_payment_pv(546.15, 7.6, 6)
#'
#' # payments given future value
#' ivt_annuity_payment_fv(941.56, 7.35, 5)
#'
#' # years given present value
#' ivt_annuity_years_pv(454.89, 10, 120)
#'
#' # years given future value
#' ivt_annuity_years_fv(610.51, 10, 100)
#'
#'
#' @export
#'
ivt_annuity_pv <- function(payment, rate, years) {

    if (rate > 1) {
       rate <- rate / 100
    }

    perpetuity <- 1 / rate
    d_factor   <- ((1 + rate) ^ years) * rate 
    discount   <- 1 / d_factor
    (perpetuity - discount) * payment

}


#' @rdname ivt_annuity_pv
#' @export
#'
ivt_annuity_fv <- function(payment , rate, years) {

    if (rate > 1) {
      rate <- rate / 100
    }

    (((1 + rate) ^ years) - 1) * (payment / rate)

}



#' @rdname ivt_annuity_pv
#' @export
#'
ivt_annuity_due_pv <- function(payment, rate, years) {

    if (rate > 1) {
       rate <- rate / 100
    }

    (1 + rate) * ivt_annuity_pv(payment, rate, years)

}


#' @rdname ivt_annuity_pv
#' @export
#'
ivt_annuity_due_fv <- function(payment, rate, years) {

    if (rate > 1) {
       rate <- rate / 100
    }

    (1 + rate) * ivt_annuity_fv(payment, rate, years)

}


#' @rdname ivt_annuity_pv
#' @export
#'
ivt_annuity_payment_fv <- function(future_value, rate, years) {

    if (rate > 1) {
       rate <- rate / 100
    }

    den <- ((1 + rate) ^ years) - 1
    (rate * future_value) / den

}

#' @rdname ivt_annuity_pv
#' @export
#'
ivt_annuity_payment_pv <- function(present_value, rate, years) {

    if (rate > 1) {
       rate <- rate / 100
    }

    den <- (1 + rate) ^ (-years)
    (rate * present_value) / (1 - den)

}

#' @rdname ivt_annuity_pv
#' @export
#'
ivt_annuity_years_fv <- function(future_value, rate, payment) {

    if (rate > 1) {
       rate <- rate / 100
    }

    num <- log(((rate * future_value) / payment) + 1)
    den <- log(1 + rate)
    num / den

}


#' @rdname ivt_annuity_pv
#' @export
#'
ivt_annuity_years_pv <- function(present_value, rate, payment) {

    if (rate > 1) {
       rate <- rate / 100
    }

    num <- rate * present_value / payment
    den <- log(1 + rate)
    (log(1 - num)) * (-1 / den)

}

















