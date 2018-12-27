#' Yield
#'
#' Computes yield to maturity, yield to call, current yield and
#' adjusted current yield.
#'
#' @param face_value Face value of the bond.
#' @param coupon_rate Coupon rate of the bond.
#' @param bond_price Price/market value of the bond.
#' @param years Years to maturity.
#'
#' @examples
#' \dontrun{
#' ivt_bond_ytm(99.94, 6.25, 139.87, 12)
#' ivt_cyield(1000, 10, 980)
#' ivt_adj_cyield(100, 8, 97.26, 3)
#' }
#'
#' @export
#'
ivt_bond_ytm <- function(face_value, coupon_rate, bond_price, years) {

    if (coupon_rate > 1) {
        coupon_rate  <- coupon_rate / 100
    }

    ytm       <- coupon_rate
    condition <- TRUE
    bp_init   <- bond_price

    while (condition) {

        if (bp_init < face_value) {
            ytm <- ytm + 0.000001
        } else {
            ytm <- ytm - 0.000001
        }

        bp <- ivt_bond_price_1(face_value, coupon_rate, years, ytm)

        if (bp_init < face_value) {
            condition <- bp > bp_init
        } else {
            condition <- bp < bp_init
        }
    }

    return(ytm * 100)

}

#' @rdname ivt_bond_ytm
#' @export
#'
ivt_cyield <- function(face_value, coupon_rate, bond_price) {

    if (coupon_rate > 1) {
        coupon_rate <- coupon_rate / 100
    }

    ((face_value * coupon_rate) / bond_price) * 100

}


#' @rdname ivt_bond_ytm
#' @export
#'
ivt_adj_cyield <- function(face_value, coupon_rate, bond_price, years) {

    if (coupon_rate > 1) {
        coupon_rate  <- coupon_rate / 100
    }

    yield <- ((face_value * coupon_rate) / bond_price) * 100
    price_diff <- (face_value - bond_price) / years
    yield + price_diff

}

