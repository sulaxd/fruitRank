# data load
recommDS <- readRDS("data/RecommDA.rds")
result <- data.frame()
load("data/nutrition.rda")
nutrition <- as.data.frame(nutrition)
fruit <- fruitRank:::getFruitTransData()
tmp <- gsub("-.*","",as.character(fruit$作物名稱[!grepl('[A-Za-z]{2}', fruit$作物代號)])) %>% unique() %>% setdiff(c("椪柑(其他)","佛利檬","雜柑","茂谷柑","其他","柿餅","橄欖","蛋黃果","黃金果"))

# if NA, remove (暫時圖方便)
nutrition <- nutrition[complete.cases(nutrition[,names(recommDS)[-c(1:3)]]),]

# 只要有出現水果關鍵字就挑出並且計算colMeans為代表
for(i in tmp){
    index <- which(nutrition$食品分類=="水果類" & grepl(i,nutrition$樣品名稱))
    if(length(index)!=0){
        result <- rbind(result, data.frame(水果名稱=i,t(colMeans(nutrition[index,c("水分-成分值(g)",names(recommDS)[-c(1:3)])])),stringsAsFactors = F))
    }
}

saveRDS(result, file="data/nutritionProcessed.rda")
names(result) <- c("作物名稱","水分-成分值(g)",names(recommDS)[-c(1:3)])
