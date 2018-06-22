tabPanel('Efficient Frontier', value = 'tab_pf_ef',

	fluidPage(

		fluidRow(

			column(1, h5('')),

			column(2, align = 'right',
				br(),
				h5('Expected Return')
			),

			column(2, align = 'left',
				
				numericInput(
					inputId = 'stock_1_return',
					label   = 'Stock 1',
					min     = 0,
					step    = 1,
					value   = 10,
					width   = '100px'
				)

			),

			column(2, align = 'left',
				
				numericInput(
					inputId = 'stock_2_return',
					label   = 'Stock 2',
					min     = 0,
					step    = 1,
					value   = 10,
					width   = '100px'
				)

			)


		),

		fluidRow(

			column(1, h5('')),

			column(2, align = 'right',
				br(),
				h5('Risk')
			),

			column(2, align = 'left',
				
				numericInput(
					inputId = 'stock_1_risk',
					label   = '',
					min     = 0,
					step    = 1,
					value   = 5,
					width   = '100px'
				)

			),

			column(2, align = 'left',
				
				numericInput(
					inputId = 'stock_2_risk',
					label   = '',
					min     = 0,
					step    = 1,
					value   = 5,
					width   = '100px'
				)

			)


		),

		fluidRow(

			column(1, h5('')),

			column(2, align = 'right',
				br(),
				h5('Correlation')
			),

			column(2, align = 'left',
				
				numericInput(
					inputId = 'ef_corr',
					label   = '',
					min     = -1,
					max     = 1,
					step    = 0.01,
					value   = 1,
					width   = '100px'
				)

			)

		),

		br(),

		fluidRow(

			column(3, h4('')),

			column(4, align = 'center', 
				actionButton(
					inputId = "submit_pf_ef",
					label   = "Calculate",
					width   = '150px'
				)
			)

		),

		fluidRow(

			column(12, align = 'center',

				br(),
				br(),

				plotOutput('pf_ef')

			)

		)

	)

)