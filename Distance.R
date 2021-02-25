#' ---
#' title: "A little R script"
#' author: "Alie"
#' date: "2021-02-25"
#' ---


## THIS SCRIPT:
# - loads the function
# - makes the data
# - calculates inter-point distances
# - fucks up the NA insertions


# Setup ------------------------------------------------------------------------

# > Load packages ----
library(tidyverse)


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

#let's do this the ugly way, shall we?

#calculate the distance between each point and the next, append to d
d$StepLength <- c(NA, 
                  dist_btw_2pts(d$X[1:(nrow(d)-1)], d$Y[1:(nrow(d)-1)],
                              d$X[2:(nrow(d))], d$Y[2:(nrow(d))]) )

#replace first point of each indiv with NA

d$StepLength[1:(nrow(d)-1)] <- ifelse(d$Indiv[2:(nrow(d))] != d$Indiv[1:(nrow(d)-1)], 
                                      NA,
                                      d$StepLength)
               
#it is wrong.