ui <- fluidPage(
  titlePanel('Fruit Data'), # Give a title
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(
        'input.dataset === "Fruit Daily Trade Market"',
        selectInput('market', '所有市場:',
          c("所有市場", unique(as.character(fruit$市場)))),
        hr(),
        selectInput('products', '所有產品:',
          c("所有產品", unique(as.character(fruit$產品))))
      ),
      conditionalPanel(
        'input.dataset === "Fruit Nutrition"',
        selectInput('classification', '所有食品分類:',
                    c("所有食品", unique(as.character(nutrition$食品分類)))),
        hr(),
        selectInput('names', '所有樣品名稱:',
                    c("所有樣品名稱", unique(as.character(nutrition$樣品名稱))))
      ),
      conditionalPanel(
        'input.dataset === "Fruit Ranking"',
        helpText('Fruit Ranking Seclect.')
      )
    ),
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel('Fruit Daily Trade Market', DT::dataTableOutput('mytable1')),
        tabPanel('Fruit Nutrition', DT::dataTableOutput('mytable2')),
        tabPanel('Fruit Ranking', DT::dataTableOutput('mytable3'))
      )
    )
  )
)
