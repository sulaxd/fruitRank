server <- function(input, output) {
    output$mytable1 <- DT::renderDataTable(DT::datatable({
        data <- dailyFruitPrice
        if (input$fruit != "所有水果") {
            data <- data[data$fruit == input$fruit, ]
        }
        if (input$market != "所有市場") {
            data <- data[data$market == input$market, ]
        }
        colnames(data) <- c("日期", "水果", "市場", "平均價格")
        data
        }))
    output$mytable2 <- DT::renderDataTable(DT::datatable({
        data2 <- nutrition
        if (input$fruits != "所有水果") {
            data2 <- data2[data2$`樣品名稱` == input$fruits, ]
        }
        data2
    }))
    output$mytable3 <- DT::renderDataTable(
        DT::datatable({
            data3 <- grading(input$age, input$gender, input$pregnant)
            colnames(data3) <- c("日期", "水果", "市場", "平均價格", "分數")
            data3
    }) %>% DT::formatRound('分數', 2))
}
