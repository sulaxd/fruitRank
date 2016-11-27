ui <- fluidPage(
  titlePanel("水果-產品日交易行情"),
  
  # Create a new Row in the UI for selectInputs
  fluidRow(
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
    ),
    column(4,
           selectInput("年齡",
                       "年齡:",
                       c("所有年齡層",
                         unique(as.character(fruit$產品))))
    ),
    column(4,
           selectInput("性別",
                       "性別:",
                       c("性別",
                         unique(as.character(fruit$產品))))
    ),
    column(4,
           selectInput("懷孕",
                       "懷孕:",
                       c("是否懷孕",
                         unique(as.character(fruit$產品))))
    )
  ),
  # Create a new row for the table.
  fluidRow(
    DT::dataTableOutput("table")
  )
)
