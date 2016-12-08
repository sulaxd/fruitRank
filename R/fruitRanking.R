#' Score Each Fruit
#'
#' Calculate score of each fruit based on its price and nutrition.
#' @importFrom magrittr %>%
#' @author Will Kuan <aiien61will@gmail.com>, Conner Chang
#' @export
grading <- function(age, gender, pregnant)
{
    rdaDF <- recommDAfilter(age = age, gender = gender, pregnant = pregnant)
    ### get priceDF
    priceDF <- getAllFruitPrice()
    ### calculate every single fruit's each nutrition percentage
    percentageTable <- apply(nuDF[, 3:15],
                               1,
                               function(x){ x / rdaDF}) %>%
                        do.call("rbind", .)
    # factor in water
    percentageTable[, colnames(nuDF)[2]] <- nuDF[, 2]

    # scale percentageTable and store the result as scoresDF
    scoresDF <- percentageTable %>% scale() %>% {
        ### weights of nutrition
        nu_weights <- c(rep(0.1, 9), rep(0.02, 5))
        data.frame(fruit = nuDF[, 1],
                   score =
                       apply(., 1, function(x){sum(x * nu_weights * 10)}))
    }
    ###  Merge priceDF and scoresDF
    scoresDF <- merge(priceDF, scoresDF)

    scoresDF$final_score <- (scoresDF$score / scoresDF$price) %>%
                            `-`(min(.)) %>%
                            `/`(sum(.)) %>%
                            `*`(100) %>%
                            `+`(1)
    scoresDF$score <- NULL
    scoresDF$final_score <- round(scoresDF$final_score, digits = 3) %>%
                                as.numeric()
    return(scoresDF)
}
