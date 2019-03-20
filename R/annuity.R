#' @title Annuity
#'
#' @description
#' Computes present value, future value, payments and years
#' for annuity and annuity due.
#'
#' @section Arguments:
#' \describe{
#'   \item{payment}{Annuity payment.}
#'   \item{rate}{Interest/discount rate.}
#'   \item{years}{Number of years/annuity payments.}
#'   \item{pv}{Present value of cash flow.}
#'   \item{fv}{Future value of cash flow.}
#' }
#'
#' @section Details:
#'
#' \code{$new()} will instantiate an object of class \code{Annuity}.
#'
#' \code{set_payment()} will set the value for payment.
#'
#' \code{set_rate()} will set the value for rate.
#'
#' \code{set_years()} will set the value for years.
#'
#' \code{set_pv()} will set the value for present value.
#'
#' \code{set_fv()} will set the value for future value.
#'
#' \code{compute_pv()} computes present value of an annuity.
#'
#' \code{compute_pv_due()} computes present value of an annuity due.
#'
#' \code{compute_fv()} computes future value of an annuity.
#'
#' \code{compute_fv_due()} computes future value of an annuity due.
#'
#' \code{compute_years()} computes years.
#'
#' \code{compute_payment()} computes payments.
#'
#' @examples
#' myAnnuity <- Annuity$new()
#'
#' # set values
#' myAnnuity$set_payment(1000)
#' myAnnuity$set_rate(8)
#' myAnnuity$set_years(5)
#'
#' # compute present value of annuity and annuity due
#' myAnnuity$compute_pv()
#' myAnnuity$compute_pv_due()
#'
#' # compute future value of annuity and annuity due
#' myAnnuity$compute_fv()
#' myAnnuity$compute_fv_due()
#'
#' # compute payment
#' myAnnuity <- Annuity$new()
#' myAnnuity$set_rate(7.35)
#' myAnnuity$set_years(5)
#'
#' # compute payment given present value
#' myAnnuity$set_pv(546.15)
#' myAnnuity$compute_payment()
#'
#' # compute payment given future value
#' myAnnuity$set_fv(941.56)
#' myAnnuity$compute_payment(pv = FALSE)
#'
#' # compute years
#' myAnnuity <- Annuity$new()
#' myAnnuity$set_rate(10)
#' myAnnuity$set_payment(120)
#'
#' # compute years given present value
#' myAnnuity$set_pv(454.89)
#' myAnnuity$compute_years()
#'
#' # compute years given future value
#' myAnnuity$set_fv(610.51)
#' myAnnuity$compute_years(pv = FALSE)
#'
#' @name Annuity
#' @docType class
#' @format An R6 class.
#' @export
#'
Annuity <- R6::R6Class("Annuity",
  public = list(
    payment = NULL,
    rate    = NULL,
    years   = NULL,
    pv      = NULL,
    fv      = NULL,

    initialize = function(payment = NA, rate = NA, years = NA, pv = NA, fv = NA) {
      self$payment <- payment
      self$rate    <- rate
      self$years   <- years
      self$pv      <- pv
      self$fv      <- fv
    },

    set_rate = function(val) {
      self$rate <- val
    },

    set_payment = function(val) {
      self$payment <- val
    },

    set_years = function(val) {
      self$years <- val
    },

    set_pv = function(val) {
      self$pv <- val
    },

    set_fv = function(val) {
      self$fv <- val
    },

    compute_pv = function() {
      private$check_rate()

      perpetuity <- 1 / self$rate
      d_factor   <- ((1 + self$rate) ^ self$years) * self$rate
      discount   <- 1 / d_factor
      (perpetuity - discount) * self$payment
    },

    compute_pv_due = function() {
    	private$check_rate()
    	(1 + self$rate) * self$compute_pv()
    },

    compute_fv = function() {
    	private$check_rate()
	    (((1 + self$rate) ^ self$years) - 1) * (self$payment / self$rate)
    },

    compute_fv_due = function() {
    	private$check_rate()
    	(1 + self$rate) * self$compute_fv()
    },

    compute_payment = function(pv = TRUE) {
    	if (pv) {
    		private$payment_pv()
    	} else {
    		private$payment_fv()
    	}
    },

    compute_years = function(pv = TRUE) {
    	if (pv) {
    		private$years_pv()
    	} else {
    		private$years_fv()
    	}
    }
  ),

  private = list(

  	check_rate = function() {
  		if (self$rate > 1) {
  			self$rate <- self$rate / 100
  		}
  	},

  	payment_fv = function() {
  		private$check_rate()
	    den <- ((1 + self$rate) ^ self$years) - 1
	    (self$rate * self$fv) / den
  	},

  	payment_pv = function() {
  		private$check_rate()
	    den <- (1 + self$rate) ^ (-self$years)
	    (self$rate * self$pv) / (1 - den)
  	},

  	years_fv = function() {
	  	private$check_rate()
	    num <- log(((self$rate * self$fv) / self$payment) + 1)
	    den <- log(1 + self$rate)
	    num / den
  	},

  	years_pv = function() {
  		private$check_rate()
	    num <- self$rate * self$pv / self$payment
	    den <- log(1 + self$rate)
	    (log(1 - num)) * (-1 / den)
  	}

  )
)
