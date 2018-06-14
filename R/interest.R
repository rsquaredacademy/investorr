#' Accrued interest
#'
#' Accrued interest on a bond.
#'
#' @param last_date Previous coupon payment date.
#' @param next_date Next coupon payment date.
#' @param settlement_date Bond settlement date.
#' @param coupon_rate Coupon rate of the bond.
#' @param face_value Face value of the bond.
#' @param freq Frequency of coupon payments.
#'
#' @examples
#' accrued_interest("2015-05-13", "2015-09-13", "2015-07-13", 7, 1000, 1)
#'
#' @export
#'
accrued_interest <- function(last_date, next_date, settlement_date, coupon_rate, face_value, freq) {

	# date transformation
	last_date   <- as.Date(last_date)
	next_date   <- as.Date(next_date)
	settle_date <- as.Date(settlement_date)
	ldays       <- as.numeric(settlement_date - last_date)
	pdays       <- as.numeric(next_date - last_date)

	# transform rate
    if (coupon_rate > 1) {
        coupon_rate %<>% divide_by(100)
    }

	# frequency conditions
	if (freq == 4) {
        coupon_rate %<>%  divide_by(4)
    } else if (freq == 2) {
        coupon_rate %<>% divide_by(2)
    } else {
        coupon_rate <- coupon_rate
    }

    # coupon payments
    coupon_payment <- face_value * coupon_rate

    # accrued interest
    coupon_payment * (ldays / pdays)

}


