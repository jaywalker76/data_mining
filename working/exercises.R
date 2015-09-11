## Exercises for Ch. 3

library(ggplot2)

source("similarity.R")
source("hashing.R")
source("plotting.R")


## Exercise 3.3.1
#                                        
# Verify the theorem from Section 3.3.3, which relates the Jaccard
# similarity to the probability of minhashing to equal values, for the
# particular case of Fig. 3.2
#
# (a) Compute the Jaccard similarity of each of the pairs of columns
#     in Fig. 3.2.

sims <- c(
  jaccard(s1, s2),
  jaccard(s1, s3),
  jaccard(s1, s4),
  jaccard(s2, s3),
  jaccard(s2, s4),
  jaccard(s3, s4))

# (b) Compute, for each pair of the columns of that figure, the fraction
#     of the 120 permutations of the rows that make the two columns hash 
#     to the same value.

# row permutations (6 rows * 4 columns) = 120 
(factorial(6)/factorial(6-2)) * 4

# not sure why this is value added, moving on.


## Exercise 3.3.2 
# 
# Using the data from Fig. 3.4, add to the signatures of the columns
# the values of the following hash functions:
# 
# (a) h3(x) = 2x + 4 mod 5.
# (b) h4(x) = 3x - 1 mod 5.

# Figure 3.4: Hash functions computed for the matrix of Fig. 3.2
s1 <- c(0,3); s2 <- c(2); s3 <- c(1,3,4); s4 <- c(0,2,3)
x <- c(1,2,3,4,0); threex <- c(1,4,2,0,3)

hashlist <- list(h1,h2,h3,h4)
setlist <- list(s1,s2,s3,s4)

solution_3.3.2 <- computeMinhashSigs(hashlist, setlist)


## Exercise 3.3.3: In Fig. 3.5 is a matrix with six rows.
#
# (a) Compute the minhash signature for each column if we use the 
#     following three hash functions: h1(x) = 2x + 1 mod 6; 
#     h2(x) = 3x + 2 mod 6; h3(x) = 5x + 2 mod 6

s1 <- c(0,0,1,0,0,1); s2 <- c(1,1,0,0,0,0); s3 <- c(0,0,0,1,1,0)
s4 <- c(1,0,1,0,1,0); element <- c(0,1,2,3,4,5)
h1 <- function(x) { (2*x + 1) %% 6 }
h2 <- function(x) { (3*x + 2) %% 6 }
h3 <- function(x) { (5*x + 2) %% 6 }

hashlist <- list(h1,h2,h3)
setlist <- list(s1,s2,s3,s4)

# the initial solution thinks all columns are the same;
# this is obviously a problem so lets take a closer look at what 
# happened.
solution_3.3.3 <- computeMinhashSigs(hashlist, setlist)

# let's first switch the binary to their corresponding values.

s1 <- c(2,5); s2 <- c(0,1); s3 <- c(3,4); s4 <- c(0,2,4)
setlist <- list(s1,s2,s3,s4)

# this looks better but I'm not sure it's quite right.
# it looks like the h2 thinks each row is identical while
# h1 thinks they look nearly identical
solution_3.3.3 <- computeMinhashSigs(hashlist, setlist)


# We can see here that minhash is not consistently finding similar sets.
# It appears as though exploring other similarity measures besides the
# Jaccard similarity of sets could be helpful. We can see from our 
# comparison that the minhash technique appears to be introducing a 
# majority of false positives.

#
# (b) Which of these hash functions are true permutations?
# 
hashlist <- list("h1"=h1,"h2"=h2,"h3"=h3)
row_count <- 5

hashPermuteDirect(hashlist, row_count)

# 
# (c) How close are the estimated Jaccard similarities for the six
#     pairs of columns to the true Jaccard similarities?


# these odd results appear to be related to the type of hash
# function chosen rather than the implementation of the minhash
# algorithm. It looks like great care is needed when choosing the
# hashing algorithms.

#x_3.3.3 <- c(jaccard(s1,s2), jaccard(s1,s3), jaccard(s1,s4),
#             jaccard(s2,s3), jaccard(s2,s4), jaccard(s3,s4))

#y_3.3.3 <- c(jaccard(solution_3.3.3[,1],solution_3.3.3[,2]),
#             jaccard(solution_3.3.3[,1],solution_3.3.3[,3]),
#             jaccard(solution_3.3.3[,1],solution_3.3.3[,4]),
#             jaccard(solution_3.3.3[,2],solution_3.3.3[,3]),
#             jaccard(solution_3.3.3[,2],solution_3.3.3[,4]),
#             jaccard(solution_3.3.3[,3],solution_3.3.3[,4]))

# comparing to 3.3.2 results
s1 <- c(0,3); s2 <- c(2); s3 <- c(1,3,4); s4 <- c(0,2,3)

x_3.3.2 <- c(jaccard(s1,s2), jaccard(s1,s3), jaccard(s1,s4),
             jaccard(s2,s3), jaccard(s2,s4), jaccard(s3,s4))
y_3.3.2 <- c(jaccard(solution_3.3.2[,1],solution_3.3.2[,2]),
             jaccard(solution_3.3.2[,1],solution_3.3.2[,3]),
             jaccard(solution_3.3.2[,1],solution_3.3.2[,4]),
             jaccard(solution_3.3.2[,2],solution_3.3.2[,3]),
             jaccard(solution_3.3.2[,2],solution_3.3.2[,4]),
             jaccard(solution_3.3.2[,3],solution_3.3.2[,4]))


## Plot the difference between 3.3.3 and 3.3.2 results

#png('minhash.png')
plot(x_3.3.2,y_3.3.2, xlab="Jaccard only",ylab="Jaccard minhash",
     main="Jaccard similarity comparison with Minhashing")
#points(x_3.3.3,y_3.3.3,col=2,pch=3)
points(x_3.3.2,y_3.3.2,col=4,pch=5)

# make this better. ggplot? might as well.
 
#dev.off()

values <- cbind(x_3.3.2,y_3.3.2)
colnames(values) <- c("Jaccard", "Minhash")
values

## It seems like the results are a little more off than we would 
## hope. Let's verify which hash functions are true permutations then
## add them to the plot

h1 <- function(x) { (2*x + 1) %% 6 }
h2 <- function(x) { (3*x + 2) %% 6 }
h3 <- function(x) { (5*x + 2) %% 6 }

hashlist <- list("h1"=h1,"h2"=h2,"h3"=h3); row_count <- 5
hashPermuteDirect(hashlist, row_count)

# hash functions from example
h1 <- function(x) { (x + 1) %% 5 }
h2 <- function(x) { (3*x + 1) %% 5 }
# hash functions from exercise 3.3.2
h3 <- function(x) { (2*x + 4) %% 5 }
h4 <- function(x) { (3*x - 1) %% 5 }

hashlist <- list("h1"=h1,"h2"=h2,"h3"=h3, "h4"=h4); row_count <- 4
hashPermuteDirect(hashlist, row_count)


# It looks like a different similarity algorithm may be helpful.
# The main issue right now is that minhash seems to struggle when
# the size of the set is small. Minhash was originally designed to 
# deduplicate web pages; shingles comprising a considerably larger
# set than something like company names. Minhash compresses large 
# documents into smaller signatures.

# How do you use a signature with a length of 250?

## Example 3.11

s <- c(0.2,0.3,0.4,0.5,0.6,0.7,0.8)
m <- matrix(data=Inf, nrow=length(s), ncol=2)
m[,1] <- s
prob <- c()
for (sProb in s) {
  prob <- c(prob, candidatePair(sProb, 5, 20))
}
m[,2] <- prob
colnames(m) <- c("s", "probCandPair")

## Figure 3.7: The S-curve
figure_3.7(m[,1],m[,2])


## Exercise 3.4.1
#  
#  Evaluate the S-curve 1-(1-s^r)^b for s=0.1,0.2,...,0.9, for
#  the following values of r and b:
#  
#  r = 3 and b = 10.
#  r = 6 and b = 20.
#  r = 5 and b = 50.

s <- c(0.2,0.3,0.4,0.5,0.6,0.7,0.8)
rlist <- list("r5b20"=5,"r3b10"=3,"r6b20"=6,"r5b50"=5)
blist <- list(20,10,20,50)

plt <- exercise_3.4.1(probs(s,rlist,blist))

ggsave(filename= "banding.pdf", plot=plt)




