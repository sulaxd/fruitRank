ui <- fluidPage(
    titlePanel('水果排名'),
    sidebarLayout(
        sidebarPanel(
            conditionalPanel(
                'input.dataset === "最新水果價格"',
                selectInput('fruit', '水果:',
                            c("所有水果", unique(as.character(dailyFruitPrice$fruit)))),
                hr(),
                selectInput('market', '市場:',
                            c("所有市場", unique(as.character(dailyFruitPrice$market))))
            ),
            conditionalPanel(
                'input.dataset === "水果營養"',
                selectInput('fruits', '水果:',
                            c("所有水果", unique(as.character(nutrition$`樣品名稱`))))
            ),
            conditionalPanel(
                'input.dataset === "水果排名"',
                selectInput('age', '年齡',
                            unique(as.character(fruitRank:::recommDA$ageRange))),
                hr(),
                selectInput('gender', '性別',
                            unique(as.character(fruitRank:::recommDA$gender))),
                hr(),
                selectInput('pregnant', '是否懷孕',
                            unique(as.character(fruitRank:::recommDA$pregnant)))
              )
        ),
        mainPanel(
              tabsetPanel(
                id = 'dataset',
                tabPanel('最新水果價格', DT::dataTableOutput('mytable1')),
                tabPanel('水果營養', DT::dataTableOutput('mytable2')),
                tabPanel('水果排名', DT::dataTableOutput('mytable3'))
          )
        )
    )
)
