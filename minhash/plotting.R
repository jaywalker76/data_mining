## Plots associated with Chapter 3

library(ggplot2)

figure_3.7 <- function(df) {
  plt <- ggplot(data=df,aes(x=s,y=probCandPair)) + geom_line() +
    labs(x="Jaccard similarity of documents",
         y="Probability of becoming a candidate")
  print(plt)
}

exercise_3.4.1 <- function(df) {
  plt <- ggplot() +
    geom_line(data=df,aes(x=s,y=r5b20, colour="r5b20")) +
    geom_line(data=df,aes(x=s,y=r3b10, colour="r3b10")) +
    geom_line(data=df,aes(x=s,y=r6b20, colour="r6b20")) +
    geom_line(data=df,aes(x=s,y=r5b50, colour="r5b50")) +
    labs(x="Jaccard similarity of documents",
         y="Probability of becoming a candidate",
         colour="r=rows, b=bands",
         title="Analysis of the Banding Technique")
  return(plt)
}

exercise_3.4.2 <- function(disagree) {
  plt <- ggplot() +
    geom_line(data=disagree, aes(x=disagree[,1],
                y=disagree[,2])) +
    geom_point() +
    labs(x= "Probability of becoming a candidate pair",
         y="Prob that signatures disagree >= one row of each of band",
         title="Threshold is 1/2; Analysis of the Banding Technique")
  return(plt)
}


