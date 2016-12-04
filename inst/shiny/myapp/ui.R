fruit <- getFruitTransData()
nutrition <- read.csv("nutrition.csv",header = TRUE,stringsAsFactors = FALSE)
ui <- fluidPage(
  titlePanel('Fruit Data'), # Give a title
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(
        'input.dataset === "Fruit Ranking"',
        helpText('Fruit Ranking Select')
      ),
      conditionalPanel(
        'input.dataset === "Fruit Daily Trade Market"',
        selectInput('products', '所有作物:',
          c("所有作物", unique(as.character(fruit$作物名稱)))),
        hr(),
        selectInput('markets', '所有市場:',
          c("所有市場", unique(as.character(fruit$市場名稱))))
      ),
      conditionalPanel(
        'input.dataset === "Fruit Nutrition"',
        selectInput('classification', '所有食品分類:',
                    c("所有食品", unique(as.character(nutrition$食品分類)))),
        hr(),
        selectInput('names', '所有樣品名稱:',
                    c("所有樣品名稱", unique(as.character(nutrition$樣品名稱))))
      )
    ),
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel('Fruit Ranking', DT::dataTableOutput('mytable1')),
        tabPanel('Fruit Daily Trade Market', DT::dataTableOutput('mytable2')),
        tabPanel('Fruit Nutrition', DT::dataTableOutput('mytable3'))
      )
    )
  )
)
