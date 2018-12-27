#' Duration
#'
#' Computes macaulay duration, modified macaulay duration and bond convexity.
#'
#' @param face_value Face/Par value of the bond.
#' @param coupon_rate Coupon rate of the bond.
#' @param yield Yield to maturity.
#' @param years Years to maturity.
#'
#' @examples
#' ivt_duration_macaulay(1000, 10, 8, 5)
#' ivt_duration_modified(1000, 10, 8, 5)
#' ivt_bond_convexity(100, 14, 12, 4)
#'
#'
#' @export
#'
ivt_duration_macaulay <- function(face_value, coupon_rate, yield, years) {

    pv <- NULL
    duration <- NULL
    macaulay <- NULL

    if (yield > 1) {
        yield <- yield / 100
    }
    if (coupon_rate > 1) {
        coupon_rate <- coupon_rate / 100
    }

    dur <- ivt_duration_internal(face_value, coupon_rate, yield, years)
    dur_sum <- colSums(dur[, c('pv', 'duration')])
    macaulay <- unname(dur_sum[2] / dur_sum[1])

}

#' @rdname ivt_duration_macaulay
#' @export
#'
ivt_duration_modified <- function(face_value, coupon_rate, yield, years) {


    macaulay <- ivt_duration_macaulay(face_value, coupon_rate, yield, years)

    if (yield > 1) {
        yield <- yield / 100
    }

    macaulay / (1 + yield)

}

#' @rdname ivt_duration_macaulay
#' @export
#'
ivt_bond_convexity <- function(face_value, coupon_rate, yield, years) {

    # transform rate
    if (yield > 1) {
        yield <- yield / 100
    }
    if (coupon_rate > 1) {
        coupon_rate <- coupon_rate / 100
    }

    convexity <- NULL

    sum(ivt_duration_internal(face_value, coupon_rate, yield, years)$convexity)
    
}


ivt_duration_internal <- function(face_value, coupon_rate, yield, years) {

    ncf <- NULL
    pv  <- NULL
    duration <- NULL

    years_seq         <- seq_len(years)
    coupon_payment    <- face_value * coupon_rate
    cf_stream         <- rep(coupon_payment, years)
    cf_stream[years]  <- cf_stream[years] + face_value

    cf_tibble <- data.frame(t = years_seq, ncf = cf_stream)

    cf_tibble$pv <- cf_tibble$ncf / ((1 + yield) ^ cf_tibble$t)
    cf_tibble$duration  <- cf_tibble$pv * cf_tibble$t
    cf_tibble$convexity = cf_tibble$duration * (cf_tibble$t + 1) / (sum(cf_tibble$pv) * ((1 + yield) ^ 2))

    return(cf_tibble)

}
