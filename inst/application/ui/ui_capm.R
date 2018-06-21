tabPanel('CAPM', value = 'tab_bond_capm',

	fluidPage(

		includeCSS("mystyle.css"),

		fluidRow(

			column(3, h5("")),
			
			column(2, br(), h5('Expected return on stock (E[R]):')),
			
			column(1, 

				numericInput(
					inputId = "capm_stock_exp_return",
					label   = "",
					value   = NULL,
					min     = 0,
					step    = 0.01,
					width   = '100px'
				)
			),
			
			column(2, br(), h5('Risk free rate (Rf):')),
			
			column(1, 

				numericInput(
					inputId = "capm_risk_free_rate",
					label   = "",
					value   = NULL,
					min     = 0,
					step    = 0.01,
					width   = '100px'
				)
			),

			column(3, h5(""))
								
		),

		fluidRow(

			column(3, h5("")),
			
			column(2, br(), h5('Expected return on market (E[Rm]):')),
			
			column(1, 

				numericInput(
					inputId = "capm_market_exp_return",
					label   = "",
					value   = NULL,
					min     = 0,
					step    = 0.01,
					width   = '100px'
				)
			),
			
			column(2, br(), h5('Beta:')	),
			
			column(1, 

				numericInput(
					inputId = "capm_beta",
					label   = "",
					value   = NULL,
					min     = 0,
					step    = 0.01,
					width   = '100px'
				)
			),

			column(3, h5(""))
								
		),

							

		br(),
		br(),


		fluidRow(

			column(4, h3("")),

			column(1, 

				actionButton(
					inputId = "compute_capm_stock_exp_return",
					label   = "E[R]",
					width   = '100px'
				)
			
			),

			column(1, 

				actionButton(
					inputId = "compute_capm_risk_free_rate",
					label   = "Rf",
					width   = '100px'
				)
			
			), 

			column(1, 

				actionButton(
					inputId = "compute_capm_market_exp_return",
					label   = "E[Rm]",
					width   = '100px'
				)
			
			),

			column(1, 

				actionButton(
					inputId = "compute_capm_beta",
					label   = "Beta",
					width   = '100px'
				)
			
			),

			column(4, h3(""))

		),

		fluidRow(

			column(4, offset =2, align = 'center',

				br(),
				br(),

				verbatimTextOutput('capm_output')

			)

		)

		
	)
)