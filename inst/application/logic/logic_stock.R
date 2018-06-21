observeEvent(input$compute_stock_price, {

	result <- ivt_stock_price(input$stock_dividend, 
		input$stock_growth_rate, input$stock_required_return, 
		as.logical(input$stock_dividend_type))

	updateNumericInput(
		session,
		inputId = "stock_price",
		value   = result
	)
})


observeEvent(input$compute_stock_dividend, {

	result <- ivt_stock_dividend(input$stock_price, 
		input$stock_growth_rate, input$stock_required_return, 
		as.logical(input$stock_dividend_type))

	updateNumericInput(
		session,
		inputId = "stock_dividend",
		value   = result
	)
})

observeEvent(input$compute_stock_return, {

	result <- ivt_stock_return(input$stock_price, 
		input$stock_dividend, input$stock_growth_rate, 
		as.logical(input$stock_dividend_type))

	updateNumericInput(
		session,
		inputId = "stock_required_return",
		value   = result
	)
})

observeEvent(input$compute_stock_growth, {

	result <- ivt_stock_growth(input$stock_price, 
		input$stock_dividend, input$stock_required_return, 
		as.logical(input$stock_dividend_type))

	updateNumericInput(
		session,
		inputId = "stock_growth_rate",
		value   = result
	)
})


