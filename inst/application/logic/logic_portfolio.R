output$ui_nprobs <- renderUI({
        ncol <- as.integer(input$nstocks)
        if (ncol < 1) {
          NULL
        } else {
          lapply(1:ncol, function(i) {
              numericInput(paste("n_stock_", i),
                        label = "",
                        value = 20,
                        width   = '100px')
          })
        }
    })

    probs_val <- reactive({
        ncol <- as.integer(input$nstocks)

        if (ncol < 1) {
          colors <- NULL
        } else {
          collect <- list(lapply(1:ncol, function(i) {
                          input[[paste("n_stock_", i)]]
                      }))

          colors <- unlist(collect)
        }
        colors

    })


output$ui_nreturns <- renderUI({
        ncol <- as.integer(input$nstocks)
        if (ncol < 1) {
          NULL
        } else {
          lapply(1:ncol, function(i) {
              numericInput(paste("n_returns_", i),
                        label = "",
                        value = 20,
                        width   = '100px')
          })
        }
    })

    returns_val <- reactive({
        ncol <- as.integer(input$nstocks)

        if (ncol < 1) {
          colors <- NULL
        } else {
          collect <- list(lapply(1:ncol, function(i) {
                          input[[paste("n_returns_", i)]]
                      }))

          colors <- unlist(collect)
        }
        colors

    })    

# calculate risk and return
result_stock_rr <- eventReactive(input$submit_stock_risk_return, {
  ivt_stock_risk_return(probs_val(), returns_val())
})


# output
output$stock_risk_return <- renderPrint({
    result_stock_rr()
})


# portfolio risk and return
output$ui_pf_nprobs <- renderUI({
        ncol <- as.integer(input$npfs)
        if (ncol < 1) {
          NULL
        } else {
          lapply(1:ncol, function(i) {
              numericInput(paste("n_pf_", i),
                        label = "",
                        value = 20,
                        width   = '100px')
          })
        }
    })

    pf_probs_val <- reactive({
        ncol <- as.integer(input$npfs)

        if (ncol < 1) {
          colors <- NULL
        } else {
          collect <- list(lapply(1:ncol, function(i) {
                          input[[paste("n_pf_", i)]]
                      }))

          colors <- unlist(collect)
        }
        colors

    })


output$ui_pf_returns1 <- renderUI({
        ncol <- as.integer(input$npfs)
        if (ncol < 1) {
          NULL
        } else {
          lapply(1:ncol, function(i) {
              numericInput(paste("n_pf_returns_1_", i),
                        label = "",
                        value = 20,
                        width   = '100px')
          })
        }
    })

    returns_1_val <- reactive({
        ncol <- as.integer(input$npfs)

        if (ncol < 1) {
          colors <- NULL
        } else {
          collect <- list(lapply(1:ncol, function(i) {
                          input[[paste("n_pf_returns_1_", i)]]
                      }))

          colors <- unlist(collect)
        }
        colors

    })  

output$ui_pf_returns2 <- renderUI({
        ncol <- as.integer(input$npfs)
        if (ncol < 1) {
          NULL
        } else {
          lapply(1:ncol, function(i) {
              numericInput(paste("n_pf_returns_2_", i),
                        label = "",
                        value = 20,
                        width   = '100px')
          })
        }
    })

    returns_2_val <- reactive({
        ncol <- as.integer(input$npfs)

        if (ncol < 1) {
          colors <- NULL
        } else {
          collect <- list(lapply(1:ncol, function(i) {
                          input[[paste("n_pf_returns_2_", i)]]
                      }))

          colors <- unlist(collect)
        }
        colors

    })  

# calculate risk and return
result_pf_rr <- eventReactive(input$submit_pf_risk_return, {
  ivt_pf_risk_return(pf_probs_val(), returns_1_val(), returns_2_val(),
    input$pf_corr, input$pf_weight_1)
})


# output
output$pf_risk_return <- renderPrint({
    result_pf_rr()
})

# efficient frontier
result_pf_ef <- eventReactive(input$submit_pf_ef, {
  ivt_pf_ef(input$stock_1_return, input$stock_1_risk,
    input$stock_2_return, input$stock_2_risk, input$ef_corr)
})


# output
output$pf_ef <- renderPlot({
    plot(result_pf_ef())
})
