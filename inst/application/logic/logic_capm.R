observeEvent(input$compute_capm_beta, {

	result <- ivt_capm_beta(input$capm_risk_free_rate, 
		input$capm_stock_exp_return,
		input$capm_market_exp_return)

	updateNumericInput(
		session,
		inputId = "capm_beta",
		value   = result
	)
})


observeEvent(input$compute_capm_stock_exp_return, {

	result <- ivt_capm_stock_return(input$capm_risk_free_rate, 
		input$capm_market_exp_return,
		input$capm_beta)

	updateNumericInput(
		session,
		inputId = "capm_stock_exp_return",
		value   = result
	)
})

observeEvent(input$compute_capm_market_exp_return, {

	result <- ivt_capm_market_return(input$capm_risk_free_rate, 
		input$capm_stock_exp_return,
		input$capm_beta)

	updateNumericInput(
		session,
		inputId = "capm_market_exp_return",
		value   = result
	)
})

observeEvent(input$compute_capm_risk_free_rate, {

	result <- ivt_capm_risk_free(input$capm_market_exp_return, 
		input$capm_stock_exp_return,
		input$capm_beta)

	updateNumericInput(
		session,
		inputId = "capm_risk_free_rate",
		value   = result
	)
})