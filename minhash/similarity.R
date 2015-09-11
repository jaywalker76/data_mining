## Similarity measures from Ch. 3 (Finding Similar Items)

jaccard <- function(S,T) {
  # Jaccard Similarity of Sets
  return(length(intersect(S,T))/length(union(S,T)))
}


