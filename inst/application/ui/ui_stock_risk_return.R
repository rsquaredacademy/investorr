tabPanel('Stock - Risk & Return', value = 'tab_stock_risk_return',

	fluidPage(

		fluidRow(

			column(12, align = 'center',
				
				numericInput(
					inputId = 'nstocks',
					label   = 'Scenarios',
					min     = 1,
					step    = 1,
					value   = 5,
					width   = '100px'
				)

			)

		),

		fluidRow(

			column(6, align = 'right', h4("Probability")),
			column(6, align = 'left', h4("Returns"))

		),

		fluidRow(

			column(6, align = 'right', uiOutput("ui_nprobs")),
			column(6, align = 'left', uiOutput("ui_nreturns"))

		),

		br(),

		fluidRow(

			column(12, align = 'center', 
				actionButton(
					inputId = "submit_stock_risk_return",
					label   = "Calculate",
					width   = '150px'
				)
			)

		),

		fluidRow(

			column(12, align = 'center',

				br(),
				br(),

				verbatimTextOutput('stock_risk_return')

			)

		)

	)

)