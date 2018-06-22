tabPanel('Capital Budgeting', value = 'tab_cb',

	fluidPage(

		fluidRow(

			column(4, align = 'center',
				
				numericInput(
					inputId = 'cb_i_flow',
					label   = 'Inital Cash Flow',
					min     = -1,
					step    = -1,
					value   = -1000,
					width   = '130px'
				)

			),

			column(4, align = 'center',
				
				numericInput(
					inputId = 'cb_n_flows',
					label   = 'Cash Flows',
					min     = 1,
					step    = 1,
					value   = 5,
					width   = '100px'
				)

			),

			column(4, align = 'center',
				
				numericInput(
					inputId = 'cb_cost',
					label   = 'Cost of Capital',
					min     = 0,
					step    = 1,
					value   = 10,
					width   = '100px'
				)

			)

		),

		fluidRow(

			column(12, align = 'center', uiOutput("ui_ncfs"))

		),

		br(),

		fluidRow(

			column(12, align = 'center', 
				actionButton(
					inputId = "submit_cb",
					label   = "Calculate",
					width   = '150px'
				)
			)

		),

		fluidRow(

			column(12, align = 'center',

				br(),
				br(),

				verbatimTextOutput('output_cb')

			)

		)

	)

)