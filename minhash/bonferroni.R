## Bonferroni's Principle Example
# 
# Assuming the data is random, calculate the expected number of 
# occurances of the events you are trying to find. If this number
# is significantly larger than the number of real instances you hope
# to find, then you must expect almost anything you find to be bogus, 
# i.e., a statistical artifact rather than evidence of what you are  
# looking to find.

## Terrorist example

# 1. There are one billion people who might be evil-doers.
# 2. Everyone goes to a hotel one day in 100.
# 3. A hotel holds 100 people. Hence, there are 100,000 hotels -- enough
#    to hold the 1% of a billion people who visit a hotel on any given
#    day.
# 4. We shall examine hotel records for 1000 days.

# probability of any two people to visit a hotel on any given day
visitor_pair <- 0.0001

# probability they will visit the same hotel

same_hotel <- visitor_pair / 10^5 # number of hotels

consecutive_visits <- same_hotel ^ 2

# number of pairs of people
people_pairs <- 5 * 10^17

# number of pairs of days
days_pair <- 5 * 10^5

terrorists <- people_pairs * days_pair * consecutive_visits 

## Exercise 1.2.1: How many would we expect if we made changes to the
#                  data?
#
# (a) The number of days of observation was raised to 2000
# (b) The number of people observed was raised to 2 billion (and there
#     were therefore 200,000 hotels).
# (c) We only reported a pair as suspect if they were at the same hotel
#     at the same time on three different days

visitors <- function(people){
  # probability of visiting on the same day
  return(0.01^people)
}

hotels <- function(visitors, n_hotels){
  # probability of visitors at the same hotel
  return(visitors / n_hotels)
}

sameHotel <- function(visitors, n_hotels) {
  # probability of visiting same hotel on both days
  return((visitors / n_hotels)^2)
}

peoplePairs <- function(n) {
  # pairs of people with simplying assumption for large n
  return(n^2/2)
}

dayPairs <- function(n) {
  # pairs of days with simplifying assumption for large n
  return(n^2/2)
}

dayTriples <- function(n) {
  # triple days with simplifying assumption for large n
  return(n^2/3)
}

likelyTerrorists <- function(people, n_hotels, population, days){
  return(peoplePairs(population) * 
         dayPairs(days) * 
         sameHotel(visitors(people), n_hotels))
}

possibleTerrorist <- function(people, n_hotels, population, days){
  return(peoplePairs(population) * 
         dayTriples(days) * 
         sameHotel(visitors(people), n_hotels))
}

## Solution

# Example provided
likelyTerrorists(2, 10^5, 10^9, 1000) == terrorists

# Problem provided
possibleTerrorist(2, 2 * 10^5, 2 * 10^9, 2000)

# Modification with params from example
possibleTerrorist(2, 10^5, 10^9, 1000)


## Lesson: Don't try to overmine your data!




