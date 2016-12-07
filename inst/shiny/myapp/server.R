server <- function(input, output) {
  output$mytable1 <- DT::renderDataTable(DT::datatable({
  data <- fruit
  if (input$market != "所有市場") {
    data <- data[data$市場 == input$market,]
  }
  if (input$products != "所有產品") {
    data <- data[data$產品 == input$products,]
  }
  data
  }))
  output$mytable2 <- DT::renderDataTable(DT::datatable({
  data2 <- nutrition
  if (input$classification != "所有食品") {
    data2 <- data2[data2$食品分類 == input$classification,]
  }
  if (input$names != "所有樣品名稱") {
    data2 <- data2[data2$樣品名稱 == input$names,]
  }
  data2
  }))

}
