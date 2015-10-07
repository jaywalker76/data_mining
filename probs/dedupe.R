## Going through some dedupe algorithms that take a probabilistic approach
#
#

library(RecordLinkage)

data(RLdata10000)

rpairs = compare.dedup(RLdata10000, identity=identity.RLdata10000,
  strcmp=TRUE, blockfld=list(1,c(5,6,7)))


