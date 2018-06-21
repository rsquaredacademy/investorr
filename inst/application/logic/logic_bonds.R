# calculate bond price
bond_price_1 <- eventReactive(input$bond_submit_1, {
  ivt_bond_price_1(input$bond_face_value_1, input$bond_coupon_rate_1,
  	input$bond_maturity_years_1, input$bond_yield_1)
})


# output
output$bond_price_output_1 <- renderPrint({
    cat('Bond Price:', bond_price_1())
})

observeEvent(input$bond_reset_1, {

		updateNumericInput(
			session,
			inputId = "bond_face_value_1",
			value   = 100
		)

		updateNumericInput(
			session,
			inputId = "bond_coupon_rate_1",
			value   = 0.1
		)

		updateNumericInput(
			session,
			inputId = "bond_maturity_years_1",
			value   = 1
		)

		updateNumericInput(
			session,
			inputId = "bond_yield_1",
			value   = 0.1
		)

}) 

# calculate bond price
bond_price_2 <- eventReactive(input$bond_submit_2, {
  ivt_bond_price_2(input$bond_face_value_2, input$bond_coupon_rate_2,
  	as.numeric(input$bond_maturity_years_2), input$bond_yield_2, 
  	as.character(input$bond_freq_2))
})


# output
output$bond_price_output_2 <- renderPrint({
    cat('Bond Price:', bond_price_2())
})

observeEvent(input$bond_reset_2, {

		updateNumericInput(
			session,
			inputId = "bond_face_value_2",
			value   = 100
		)

		updateNumericInput(
			session,
			inputId = "bond_coupon_rate_2",
			value   = 0.1
		)

		updateNumericInput(
			session,
			inputId = "bond_maturity_years_2",
			value   = 1
		)

		updateNumericInput(
			session,
			inputId = "bond_yield_2",
			value   = 0.1
		)

		updateSelectInput(
			session,
			inputId = "bond_freq_2",
			selected = "annual"
		)

}) 


# calculate bond price
bond_price_3 <- eventReactive(input$bond_submit_3, {
  ivt_bond_price_3(input$bond_face_value_3, input$bond_redemption_value_3, 
  	input$bond_coupon_rate_3, input$bond_yield_3, 
  	input$bond_settle_date_3, input$bond_maturity_date_3,
  	as.character(input$bond_freq_3))
})


# output
output$bond_price_output_3 <- renderPrint({
    cat('Bond Price:', bond_price_3())
})

observeEvent(input$bond_reset_3, {

		updateNumericInput(
			session,
			inputId = "bond_face_value_3",
			value   = 100
		)
		
		updateNumericInput(
			session,
			inputId = "bond_redemption_value_3",
			value   = 100
		)

		updateNumericInput(
			session,
			inputId = "bond_coupon_rate_3",
			value   = 0.1
		)

		updateNumericInput(
			session,
			inputId = "bond_yield_3",
			value   = 0.1
		)

		updateDateInput(
			session,
			inputId = "bond_settle_date_3",
			value   = lubridate::today()
		)

		updateDateInput(
			session,
			inputId = "bond_maturity_date_3",
			value   = lubridate::today()
		)

		updateSelectInput(
			session,
			inputId = "bond_freq_3",
			selected = "annual"
		)

}) 


# calculate bond price
bond_price_4 <- eventReactive(input$bond_submit_4, {
  ivt_bond_price_4(input$bond_face_value_3, 
  	input$bond_coupon_rate_4, input$bond_yield_4, 
  	input$bond_settle_date_4, input$bond_maturity_date_4,
  	as.character(input$bond_freq_4))
})


# output
output$bond_price_output_4 <- renderPrint({
    cat('Bond Price:', bond_price_4())
})

observeEvent(input$bond_reset_4, {

		updateNumericInput(
			session,
			inputId = "bond_face_value_4",
			value   = 100
		)

		updateNumericInput(
			session,
			inputId = "bond_coupon_rate_4",
			value   = 0.1
		)

		updateNumericInput(
			session,
			inputId = "bond_yield_4",
			value   = 0.1
		)

		updateDateInput(
			session,
			inputId = "bond_settle_date_4",
			value   = lubridate::today()
		)

		updateDateInput(
			session,
			inputId = "bond_maturity_date_4",
			value   = lubridate::today()
		)

		updateSelectInput(
			session,
			inputId = "bond_freq_4",
			selected = "annual"
		)

}) 


# calculate macaulay duration
macaulay_duration <- eventReactive(input$bond_macd_submit, {
  ivt_duration_macaulay(input$bond_macd_face_value, 
  	input$bond_macd_coupon_rate, input$bond_macd_yield, 
  	input$bond_macd_maturity_years)
})


# output
output$bond_macd_output <- renderPrint({
    cat('Macaulay Duration:', macaulay_duration())
})

observeEvent(input$bond_macd_reset, {

		updateNumericInput(
			session,
			inputId = "bond_macd_face_value",
			value   = 100
		)

		updateNumericInput(
			session,
			inputId = "bond_macd_coupon_rate",
			value   = 0.1
		)

		updateNumericInput(
			session,
			inputId = "bond_macd_yield",
			value   = 0.1
		)

		updateNumericInput(
			session,
			inputId = "bond_macd_maturity_years",
			value   = 1
		)
}) 

# calculate modified duration
modified_duration <- eventReactive(input$bond_mod_submit, {
  ivt_duration_modified(input$bond_mod_face_value, 
  	input$bond_mod_coupon_rate, input$bond_mod_yield, 
  	input$bond_mod_maturity_years)
})


# output
output$bond_mod_output <- renderPrint({
    cat('Macaulay Duration:', modified_duration())
})

observeEvent(input$bond_mod_reset, {

		updateNumericInput(
			session,
			inputId = "bond_mod_face_value",
			value   = 100
		)

		updateNumericInput(
			session,
			inputId = "bond_mod_coupon_rate",
			value   = 0.1
		)

		updateNumericInput(
			session,
			inputId = "bond_mod_yield",
			value   = 0.1
		)

		updateNumericInput(
			session,
			inputId = "bond_mod_maturity_years",
			value   = 1
		)
}) 

# calculate bond convexity
bond_convexity <- eventReactive(input$bond_convex_submit, {
  ivt_bond_convexity(input$bond_convex_face_value, 
  	input$bond_convex_coupon_rate, input$bond_convex_yield, 
  	input$bond_convex_maturity_years)
})


# output
output$bond_convex_output <- renderPrint({
    cat('Bond Convexity:', bond_convexity())
})

observeEvent(input$bond_convex_reset, {

		updateNumericInput(
			session,
			inputId = "bond_convex_face_value",
			value   = 100
		)

		updateNumericInput(
			session,
			inputId = "bond_convex_coupon_rate",
			value   = 0.1
		)

		updateNumericInput(
			session,
			inputId = "bond_convex_yield",
			value   = 0.1
		)

		updateNumericInput(
			session,
			inputId = "bond_convex_maturity_years",
			value   = 1
		)
}) 


# calculate bond ytm
bond_ytm <- eventReactive(input$bond_ytm_submit, {
  ivt_bond_ytm(input$bond_ytm_face_value, 
  	input$bond_ytm_coupon_rate, input$bond_ytm_price, 
  	input$bond_ytm_maturity_years)
})


# output
output$bond_ytm_output <- renderPrint({
    cat('Yield to Maturity:', bond_ytm())
})

observeEvent(input$bond_ytm_reset, {

		updateNumericInput(
			session,
			inputId = "bond_ytm_face_value",
			value   = 100
		)

		updateNumericInput(
			session,
			inputId = "bond_ytm_coupon_rate",
			value   = 0.1
		)

		updateNumericInput(
			session,
			inputId = "bond_ytm_yield",
			value   = 0.1
		)

		updateNumericInput(
			session,
			inputId = "bond_ytm_maturity_years",
			value   = 1
		)
}) 


# calculate bond current yield
bond_cyield <- eventReactive(input$bond_cyield_submit, {
  ivt_cyield(input$bond_cyield_face_value, 
  	input$bond_cyield_coupon_rate, input$bond_cyield_price)
})


# output
output$bond_cyield_output <- renderPrint({
    cat('Current Yield:', bond_cyield())
})

observeEvent(input$bond_cyield_reset, {

		updateNumericInput(
			session,
			inputId = "bond_cyield_face_value",
			value   = 100
		)

		updateNumericInput(
			session,
			inputId = "bond_cyield_coupon_rate",
			value   = 0.1
		)

		updateNumericInput(
			session,
			inputId = "bond_cyield_price",
			value   = 100
		)

}) 


# calculate adjusted current yield
bond_adj_cyield <- eventReactive(input$bond_adj_cyield_submit, {
  ivt_adj_cyield(input$bond_adj_cyield_face_value, 
  	input$bond_adj_cyield_coupon_rate, input$bond_adj_cyield_price,
  	input$bond_adj_cyield_maturity_years)
})


# output
output$bond_adj_cyield_output <- renderPrint({
    cat('Adjusted Current Yield:', bond_adj_cyield())
})

observeEvent(input$bond_adj_cyield_reset, {

		updateNumericInput(
			session,
			inputId = "bond_adj_cyield_face_value",
			value   = 100
		)

		updateNumericInput(
			session,
			inputId = "bond_adj_cyield_coupon_rate",
			value   = 0.1
		)

		updateNumericInput(
			session,
			inputId = "bond_adj_cyield_price",
			value   = 100
		)

		updateNumericInput(
			session,
			inputId = "bond_adj_cyield_maturity_years",
			value   = 1
		)

})