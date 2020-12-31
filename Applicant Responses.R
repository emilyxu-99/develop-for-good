library(tidyverse)
library(tidyr)
library(dplyr)
library(stringr)
library(sjlabelled)

responses <- 
  read_csv('Develop for Good Winter 2021 Application (Responses).csv')

## Split responses
split <- 
  data.frame(responses$`Email Address`, str_split_fixed
            (responses$`Which of these projects/organizations would you be happy to work with?`, ", ", 30))

split$`Email Address`<- split$responses..Email.Address.
split$responses..Email.Address. <- NULL

colnames(split)<-sub("X", "Non-Profit ", colnames(split), fixed=TRUE)

split2<- 
  data.frame(responses$`Email Address`, str_split_fixed
            (responses$`What role(s) would you like to be considered for?`, ", ", 5))

split2$`Email Address`<- split2$responses..Email.Address.
split2$responses..Email.Address. <- NULL

colnames(split2)<-sub("X", "Position ", colnames(split2), fixed=TRUE)

split3 <-
  data.frame(responses$`Email Address`, str_split_fixed
            (responses$`Do you have experience with any of the following?`, ", ", 14))

split3$`Email Address`<- split3$responses..Email.Address.
split3$responses..Email.Address. <- NULL

colnames(split3)<-sub("X", "Skill ", colnames(split3), fixed=TRUE)

## Join data

final <-
  list(split, split2, split3, responses) %>% 
  reduce(inner_join, by ="Email Address")

# Remove duplicate columns

final <- final[!duplicated(as.list(final))]
