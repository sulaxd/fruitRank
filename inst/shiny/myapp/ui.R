ui <- fluidPage(
  titlePanel("水果-產品日交易行情"),
  
  # Create a new Row in the UI for selectInputs
  fluidRow(
    column(4,
           selectInput("日期",
                       "日期:",
                       c("所有日期",
                         unique(as.character(fruit$日期))))
    ),
    column(4,
           selectInput("市場",
                       "市場:",
                       c("所有市場",
                         unique(as.character(fruit$市場))))
    ),
    column(4,
           selectInput("產品",
                       "產品:",
                       c("所有產品",
                         unique(as.character(fruit$產品))))
    )
  ),
  # Create a new row for the table.
  fluidRow(
    DT::dataTableOutput("table")
  )
)
