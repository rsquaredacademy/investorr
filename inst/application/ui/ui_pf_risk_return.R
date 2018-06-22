tabPanel('Porfolio - Risk & Return', value = 'tab_pf_risk_return',

	fluidPage(

		fluidRow(

			column(4, align = 'center',
				
				numericInput(
					inputId = 'npfs',
					label   = 'Scenarios',
					min     = 1,
					step    = 1,
					value   = 5,
					width   = '100px'
				)

			),

			column(4, align = 'center',
				
				numericInput(
					inputId = 'pf_corr',
					label   = 'Correlation',
					min     = -1,
					max     = 1,
					step    = 0.01,
					value   = 1,
					width   = '100px'
				)

			),

			column(4, align = 'center',
				
				numericInput(
					inputId = 'pf_weight_1',
					label   = 'Stock 1 (%)',
					min     = 0,
					max     = 1,
					step    = 0.01,
					value   = 0.5,
					width   = '100px'
				)

			)


		),

		fluidRow(

			column(4, align = 'center', h4("Probability")),
			column(4, align = 'center', h4("Stock 1")),
			column(4, align = 'center', h4("Stock 2"))

		),

		fluidRow(

			column(4, align = 'center', uiOutput("ui_pf_nprobs")),
			column(4, align = 'center', uiOutput("ui_pf_returns1")),
			column(4, align = 'center', uiOutput("ui_pf_returns2"))

		),

		br(),

		fluidRow(

			column(12, align = 'center', 
				actionButton(
					inputId = "submit_pf_risk_return",
					label   = "Calculate",
					width   = '150px'
				)
			)

		),

		fluidRow(

			column(12, align = 'center',

				br(),
				br(),

				verbatimTextOutput('pf_risk_return')

			)

		)

	)

)