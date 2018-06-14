#' Margin
#'
#' Equity margin.
#'
#' @param num_shares Number of shares.
#' @param init_price Initial price of shares.
#' @param final_price Final price of shares.
#' @param equity Equity amount.
#' @param int_rate Interest rate.
#'
#' @examples
#' margin(200, 100, 70, 10000, 9)
#'
#' @export
#'
margin <- function(num_shares, init_price, final_price, equity, int_rate) {

    # convert interest rate
    int_rate      <- int_rate / 100

    # compute initial and final investment value
    initial_value <- num_shares * init_price
    final_value   <- num_shares * final_price
    price_change  <- round(((final_price - init_price) / init_price) * 100, 2)
    own_money     <- initial_value - equity

    # compute interest on borrowed money
    interest      <- int_rate * equity
    payable       <- interest + equity

    # compute return and rate of return
    return_invt   <- final_value - payable
    returns       <- return_invt - own_money
    rate_return   <- returns / own_money

    cat(price_change, "% ", "   ", final_value, "     ", payable, "    ", rate_return, "\n")
}



