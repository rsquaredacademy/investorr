# calculate bond price
bond_price_1 <- eventReactive(input$bond_submit, {
  ivt_bond_price_1(input$bond_face_value, input$bond_coupon_rate,
  	input$bond_maturity_years, input$bond_yield)
})


# output
output$bond_price_output <- renderPrint({
    bond_price_1()
})

observeEvent(input$bond_reset, {

		updateNumericInput(
			session,
			inputId = "bond_face_value",
			value   = 100
		)

		updateNumericInput(
			session,
			inputId = "bond_coupon_rate",
			value   = 0.1
		)

		updateNumericInput(
			session,
			inputId = "bond_maturity_years",
			value   = 1
		)

		updateNumericInput(
			session,
			inputId = "bond_yield",
			value   = 0.1
		)

}) 