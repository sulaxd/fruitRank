recommDAfilter <- function(age, gender, pregnant){
    recommDA <- readRDS("data/RecommDA.rds")
    if(age=="1-") return(recommDA[1,-(1:3)])
    if(age=="1-3") return(recommDA[2,-(1:3)])
    if(age=="4-9"){
        if(gender=="m"){
            return(recommDA[3,-(1:3)])
        }else{
            return(recommDA[4,-(1:3)])
        }
    }

    if(gender=="m"){
        result <- recommDA[which(recommDA$ageRange == age & recommDA$gender == gender), ]
    }else{
        result <- recommDA[which(recommDA$ageRange == age & recommDA$gender == gender & recommDA$pregnant == pregnant), ]
    }
    return(result)
}
