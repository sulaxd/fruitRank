server <- function(input, output) {

  # Filter data based on selections
  output$table <- DT::renderDataTable(DT::datatable({
    data <- fruit
    if (input$市場 != "所有市場") {
      data <- data[data$市場 == input$市場,]
    }
    if (input$產品 != "所有產品") {
      data <- data[data$產品 == input$產品,]
    }
    data
  }))

}
