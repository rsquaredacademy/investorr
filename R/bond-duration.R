#' Duration
#'
#' Computes macaulay duration, modified macaulay duration and bond convexity.
#'
#' @param face_value Face/Par value of the bond.
#' @param coupon_rate Coupon rate of the bond.
#' @param yield Yield to maturity.
#' @param years Years to maturity.
#' @param freq Frequency of coupon payments.
#'
#' @examples
#' ivt_duration_macaulay(1000, 10, 8, 5)
#' ivt_duration_modified(1000, 10, 8, 5)
#' ivt_bond_convexity(100, 14, 12, 4)
#'
#' @importFrom dplyr select summarise_all mutate pull funs
#' @importFrom tibble tibble
#'
#' @export
#'
ivt_duration_macaulay <- function(face_value, coupon_rate, yield, years) {

    # transform rate
    if (yield > 1) {
        yield %<>% divide_by(100)
    }
    if (coupon_rate > 1) {
        coupon_rate %<>% divide_by(100)
    }

    ivt_duration_internal(face_value, coupon_rate, yield, years) %>%
        select(pv, duration) %>%
        summarise_all(funs(sum)) %>%
        mutate(macaulay = duration / pv) %>%
        pull(macaulay)

}

#' @rdname ivt_duration_macaulay
#' @export
#'
ivt_duration_modified <- function(face_value, coupon_rate, yield, years) {


    macaulay <- ivt_duration_macaulay(face_value, coupon_rate, yield, years)

    if (yield > 1) {
        yield %<>% divide_by(100)
    }

    macaulay / (1 + yield)

}

#' @rdname ivt_duration_macaulay
#' @export
#'
ivt_bond_convexity <- function(face_value, coupon_rate, yield, years) {

    # transform rate
    if (yield > 1) {
        yield %<>% divide_by(100)
    }
    if (coupon_rate > 1) {
        coupon_rate %<>% divide_by(100)
    }

    ivt_duration_internal(face_value, coupon_rate, yield, years) %>%
        pull(convexity) %>%
        sum()

}


ivt_duration_internal <- function(face_value, coupon_rate, yield, years) {

    years_seq         <- seq_len(years)
    coupon_payment    <- face_value * coupon_rate
    cf_stream         <- rep(coupon_payment, years)
    cf_stream[years] %<>% add(face_value)

    cf_tibble <- tibble(t = years_seq,
                        ncf = cf_stream)

    cf_tibble %<>%
        mutate(
            pv = ncf / ((1 + yield) ^ t),
            duration  = pv * t,
            convexity = duration * (t + 1) / (sum(pv) * ((1 + yield) ^ 2))
        )

    return(cf_tibble)

}
