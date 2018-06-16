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
#' @importFrom magrittr raise_to_power
#'
#' @export
#'
ivt_annuity_pv <- function(payment, rate, years) {

    if (rate > 1) {
       rate %<>% divide_by(100)
    }

    perpetuity <- 1 / rate

    d_factor <-
      1 %>%
      add(rate) %>%
      raise_to_power(years) %>%
      multiply_by(rate)

    discount   <- 1 / d_factor

    perpetuity %>%
      subtract(discount) %>%
      multiply_by(payment)

}


#' @rdname ivt_annuity_pv
#' @export
#'
ivt_annuity_fv <- function(payment , rate, years) {

    if (rate > 1) {
       rate %<>% divide_by(100)
    }

    1 %>%
      add(rate) %>%
      raise_to_power(years) %>%
      subtract(1) %>%
      divide_by(rate) %>%
      multiply_by(payment)

}



#' @rdname ivt_annuity_pv
#' @export
#'
ivt_annuity_due_pv <- function(payment, rate, years) {

    if (rate > 1) {
       rate %<>% divide_by(100)
    }

    1 %>%
      add(rate) %>%
      multiply_by(ivt_annuity_pv(payment, rate, years))

}


#' @rdname ivt_annuity_pv
#' @export
#'
ivt_annuity_due_fv <- function(payment, rate, years) {

    if (rate > 1) {
       rate %<>% divide_by(100)
    }

    1 %>%
      add(rate) %>%
      multiply_by(ivt_annuity_fv(payment, rate, years))

}


#' @rdname ivt_annuity_pv
#' @export
#'
ivt_annuity_payment_fv <- function(future_value, rate, years) {

    if (rate > 1) {
       rate %<>% divide_by(100)
    }

    den <-
      1 %>%
      add(rate) %>%
      raise_to_power(years) %>%
      subtract(1)

    rate %>%
      multiply_by(future_value) %>%
      divide_by(den)

}

#' @rdname ivt_annuity_pv
#' @export
#'
ivt_annuity_payment_pv <- function(present_value, rate, years) {

    if (rate > 1) {
       rate %<>% divide_by(100)
    }

    den <-
      1 %>%
      add(rate) %>%
      raise_to_power(-years) 


    rate %>%
      multiply_by(present_value) %>%
      divide_by(1 - den)

}

#' @rdname ivt_annuity_pv
#' @export
#'
ivt_annuity_years_fv <- function(future_value, rate, payment) {

    if (rate > 1) {
       rate %<>% divide_by(100)
    }

    num <-
      rate %>%
      multiply_by(future_value) %>%
      divide_by(payment) %>%
      add(1) %>%
      log()

    den <-
      1 %>%
      add(rate) %>%
      log()

    num / den

}


#' @rdname ivt_annuity_pv
#' @export
#'
ivt_annuity_years_pv <- function(present_value, rate, payment) {

    if (rate > 1) {
       rate %<>% divide_by(100)
    }

    num <-
      rate %>%
      multiply_by(present_value) %>%
      divide_by(payment)

    den <-
      1 %>%
      add(rate) %>%
      log()

    1 %>%
      subtract(num) %>%
      log() %>%
      divide_by(den) %>%
      multiply_by(-1)

}

















