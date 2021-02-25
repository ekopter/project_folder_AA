#' ---
#' title: "A little R script"
#' author: "Alie"
#' date: "2021-02-25"
#' ---


## THIS SCRIPT:
# - loads the function called distance_btw_2pts
# - makes a data frame called d that has 300 xy points split between three individuals
# - calculates inter-point distances, which would be useful for if they had a long distance relationship, and had to decide where to meet each other for ROMANCE. 
# - does the NA insertions PERFECTLY, albeit, a bit clunky


# Setup ------------------------------------------------------------------------

# > Load packages ----
library(tidyverse)# i am being held hostage by Hadley Wickham, that is the only reason I am using this. 


# > Load fcns ----

#get the distance between two (X,Y) points

dist_btw_2pts <- function(X1, Y1, X2, Y2) {
  return(sqrt( ( (X1 - X2) ^ 2) + ( (Y1 - Y2) ^ 2)))
}


# > Make data ----

d <- data.frame(Y = sample(1:330, 300),
                X = sample(500:1000, 300),
                Indiv = rep(c("Olga", "Bob", "Freddy"), each = 100)
              )
str(d)


# Fancy calculations -----------------------------------------------------------

#let's do this the ugly way, shall we? Yes lets. 

#calculate the distance between each point and the next, append to d
boom <- dist_btw_2pts(d$X[1:(nrow(d)-1)], d$Y[1:(nrow(d)-1)],
                      d$X[2:(nrow(d))], d$Y[2:(nrow(d))])

#replace first point of each indiv with NA
boom[which(d$Indiv[1:(nrow(d)-1)] != d$Indiv[2:(nrow(d))])] <- NA


d$StepLength <- c(NA, boom)
               
#fixed it. this works