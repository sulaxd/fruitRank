### load nutrition template
nu.df <- readRDS("data/nutritionProcessed.rda")

### laod RDA template
rda.df <- recommDAfilter("50+", "f", "1")

### create price template for temporary use
priceTable <-data.frame(fruit = nu.df[,1], price = sample(20:100, 18, replace = FALSE))

### create empty data.frame buider
emptyDF_Builder <- function(rowNum, colNum)
{
  ### create an empty data.frame with column names only for initial empty table 
  emptyMat <- data.frame(matrix(data = numeric(0), ncol = 14)) %>% 
    set_colnames(., nu.factor) 
  
  return(emptyMat)
}


grading <- function(nu.df, rda.df, priceTable)
{
  if(!requireNamespace("magrittr",quietly = TRUE)){
    install.packages("magrittr"); requireNamespace("magrittr", quietly = TRUE)
  }else{
    requireNamespace("magrittr", quietly = TRUE)
  }
  
  if(!requireNamespace("data.table",quietly = TRUE)){
    install.packages("data.table"); requireNamespace("data.table", quietly = TRUE)
  }else{
    requireNamespace("data.table", quietly = TRUE)
  }
  
  if(!requireNamespace("psych",quietly = TRUE)){
    install.packages("psych"); requireNamespace("psych", quietly = TRUE)
  }else{
    requireNamespace("psych", quietly = TRUE)
  }
  
  ### name variables
  nu.factor <- c("水分-成分值(g)", "維生素A效力(2)(RE)-成分值(ug)", "維生素E效力(α-TE)-成分值(mg)",           
                 "維生素C-成分值(mg)", "維生素B1-成分值(mg)", "維生素B2-成分值(mg)", "菸鹼素-成分值(mg)",            
                 "維生素B6-成分值(mg)", "葉酸-成分值(ug)", "鈣-成分值(mg)", "磷-成分值(mg)", 
                 "鎂-成分值(mg)", "鐵-成分值(mg)", "鋅-成分值(mg)" )
  
  ### give each weighted value
  weights <- c(rep(0.1, 9), rep(0.02, 5))
  
  ### calculate every single fruit's each nutrition percentage
  percentageTable <- apply(nu.df[,3:15], 1, function(x){ return(x/rda.df[,4:16])}) %>% 
    data.table::rbindlist(.) %>% 
    magrittr::set_rownames(., nu.df[, "水果名稱" ])
  
  percentageTable[, "水分-成分值(g)" := nu.df[, 2]]
  
  ### summary
  desc <- psych::describe(percentageTable)
  
  ### create an empty table
  scoreMat <- emptyDF_Builder()
  
  ### adjust each fruit's nutrition scores
  for(i in nu.factor[1:14]){
    scoreMat[1:18, i] <- scale(percentageTable[, i, with = FALSE], center = desc[i, "mean"], scale = desc[i, "sd"] )
  }
  
  ### define rownames
  scoreMat <- magrittr::set_rownames(scoreMat, nu.df[, "水果名稱" ])
  
  ### calculate ranking score
  scores.today <- apply(scoreMat[, 1:13], 1, function(x){ return( sum(x * weights * 10)) } ) %>% 
    magrittr::divide_by(., priceTable[, "price"]) %>%  # for a fruit : total nutrition per 1 kg / today price per kg
    magrittr::subtract(min(.)) %>%  # translation for no negative value shown for in case of misunderstanding
    magrittr::divide_by(., sum(.)) %>%   # divided by sum of each variable for computing percentage
    magrittr::multiply_by(100) %>%  # computing percentage
    sort(., decreasing = TRUE) %>% 
    magrittr::add(., 1) %>%  # set min score = 1 
    as.data.frame(.) %>%    
    magrittr::set_colnames(., "Ranking Score")
    
  return(scores.today)
}


