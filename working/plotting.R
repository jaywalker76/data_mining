## Plots associated with Chapter 3

library(ggplot2)

figure_3.7 <- function(df) {
  plt <- ggplot(data=df,aes(x=s,y=probCandPair)) + geom_line() +
    labs(x="Jaccard similarity of documents",
         y="Probability of becoming a candidate")
  print(plt)
}

exercise_3.4.1 <- function(df) { }


