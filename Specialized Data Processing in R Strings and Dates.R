---
  title: "Specialized Data Processing in R: Strings and Date"
author: "Tosin"
date: "7/29/2019"
output: html_document
---
library(tidyverse)
#Indexing Strings
nums <- 1:5
nums[1]
words <- "Dataquest is awesome"
words[3]
words[1]
# In order to get a sub_string we need to use the str_sub() function
str_sub(words,1,9)

first_four_letters <- str_sub(words,1,4)
first_four_letters
last_to_letters <- str_sub(words,19,20)
last_to_letters

#Handling Word Casing
library(readr)
recent_grads <- read.csv("recent_grads.csv")
colnames(recent_grads)

#change to lower case
lower <- str_to_lower(colnames(recent_grads))
#change to upper case
str_to_upper(colnames(recent_grads))
colnames(recent_grads) <- lower
colnames(recent_grads)

#String Trimming & Padding
padded_string <- "     Dataquest     "
str_trim(padded_string,side = "both")

str_pad("Dataquest", width = 20, side = "both", pad = " ")

recent_grads <- recent_grads %>% mutate(formatted_major_code = str_pad(recent_grads$major_code, width = 7, side ="left", pad = 0))
view(recent_grads)

#String Splitting
sentence <- "The stringr library is essential to string manipulation"
str_split(sentence," ")
sentence_word <- str_split(sentence, " ")[[1]]
sentence_word[1]
sentence_word[1:3]

input_sentence <- "You'll need to split this sentence"
output_1 <- str_split(input_sentence," ")[[1]]
output_2 <- output_1[1:4]
output_1

#String Concatenation
words <- c("String","concatentation","via","function")
str_c(words,collapse = " ")


#String Detection
review <- "I really enjoyed this product an I thought it was great for the price"
str_detect(review, "great")

recent_grads <- recent_grads %>% mutate(is_arts = str_detect(recent_grads$major, "ARTS"))
view(recent_grads)

#String Replacement
review2 <- "I really enjy codnig in R and wnt to lrn more."
str_replace(review2, pattern = "enjy",replacement = "enjoy")
str_replace(review2, pattern = "and wnt to lrn more", replacement = "")

review3 <- "I want to lrn R, and I definitely want to lrn more." 
str_replace(review3,pattern = "lrn",replacement = "learn")
str_replace_all(review3, pattern = "lrn", replacement = "learn")

str_replace_all(recent_grads$major_category, pattern = "Engineering",replacement = "Engr")


#Date Representation
date1 <- "20/04/21"
date2 <- "04-21-20"

library(lubridate)
library(reprex)
ymd(date1)
mdy(date2)

date1 <- "01011970"
date2 <- "2019-03-04"

date_standardized1 <- mdy(date1)
date_standardized2 <- ymd(date2)


date_standardized1
date_standardized2

# Time Representation 
date1 <- "20/04/21 13:30:00"
date2 <- "04-21-2020 01-30 PM"

ymd_hms(date1)
mdy_hm(date2, tz = "America/New_York")
Sys.timezone()

datetime1 <- "01-01-1970-00-00-00"
datetime2 <- "2019-03-14 1:59 AM"

datetime_standardized1 <- mdy_hms(datetime1)
datetime_standardized1

datetime_standardized2 <- ymd_hm(datetime2)
datetime_standardized2

#Unix Representation
library(dplyr)
now <- Sys.time()
now
now %>% ymd_hms() %>% as.numeric()

#Component Extraction
date <- ymd("2020-07-30")
year(date)
month(date)
day(date)

# wday() function takes in a date, and it returns the day
wday(date)
wday(date, label = T)

yday(date)

input_date <- "2020-11-13 13:13:13"
input_date <- ymd_hms(input_date)

month(input_date)
wday(input_date, label = T)


#Time Span Calculation
ymd("2020-04-21") - ymd("2020-04-20")
ymd("1996-06-23") - ymd("2020-07-30")

ymd_hms("2020-04-21 17:00:00") - ymd_hms("2020-04-21 08:30:00")

now <- Sys.time() %>% as_datetime
march <- ymd_hms("2015-03-01 00:00:00")
now - march

#Duration and Periods
dur <- duration(day = 1,hour = 1,minute = 30)
dur
ymd("2020-04-21") + dur

per <- period(years = 1, months = 1, days = 1)
per

ymd("2020-04-21") + per

start <- ymd("2020/05/01")
dur <- duration(day = 5,hour=12)
duration_end <- start + dur
duration_end
per <- period(months = 1, days=1)
period_end = start + per
period_end

#Time Zone Manipulation
example <- ymd_hms("2020-05-01 12:00:00")
example

with_tz(example, tz = "America/Los_Angeles")
OlsonNames()[1:9]


#The Map Function in R
profits <- c()
prices <- c(10,20,30,40,50)
for(price in prices){
  calc = -4*price^2 + 400 + price
  profits = c(profits,calc)
}
profits

scores <- read.csv("scores.csv")
head(scores, 3)


#Preparing Our Function
format_score <- function(string){
  a = str_replace(string, "%","")
  a = as.numeric(a)
  return(a)
}
view(scores)

s <- str_replace(percent_string,"%","")
s <- as.numeric(s)
s

percent_string <- "74%"
b <- format_score(percent_string)
b

# The map Functions
add_one <- function(value){
  return(value + 1)
}
add_one(c(1,2,3,4,5)) 

inputs <- 1:5

map(inputs,add_one)

input_score <- c("83%","29%","76%")
format_score <- function(score){
  fmt_string <- str_replace(score,"%","")
  num <- as.numeric(fmt_string)
  return(num)
}

output_scores <- map(input_score,format_score)
third_element <- output_scores[[3]]
third_element

#Creating a New Column With Map
student_scores <- scores %>% mutate(new_writing_score = map(writing_score, format_score))
colnames(student_scores)
student_scores$new_writing_score[1:3]

scores <- scores %>% mutate(new_writing_score = unlist(map(writing_score,format_score)))
scores$new_writing_score
view(scores)

scores <- scores %>% mutate(new_math_score = unlist(map(math_score,format_score)))

scores <- scores %>% mutate(new_science_score = unlist(map(science_score,format_score)))


#Two Input Variation
input1 <- 1:5
input2 <- 6:10

add_two_values <- function(x,y){
  return(x+y)
}
outputs <- map2(input1,input2, add_two_values)
outputs
as.numeric(x),toString(y)

add_extra_credit <- function(x,y){
  if(y == "None"){x = x+0}
  if(y == "Low"){x = x+1}
  if(y == "High"){x =x+5}
  return(x)
}

input_score <- 50
add_extra_credit(input_score,"High")
add_extra_credit(input_score,"Low")
add_extra_credit(input_score,"None")

#Two Input Variation Map
example_tibble <- tibble(x = 1:5 , y = 6:10)
example_tibble <- example_tibble %>% mutate(sum_column = unlist(map2(x,y,add_two_values)))
example_tibble

scores <- scores %>% mutate(adjusted_math_score = unlist(map2(new_math_score,math_extra_credit,add_extra_credit)))
view(scores)

#lists as inputs
input_list <- list(c(1,2),c(3,4),c(5,6),c(7,8),c(9,10))
output <- map(input_list,sum)
output

# Vectorizing Summaries
avg_score_by_student <- scores %>% group_by(names) %>% summarise(avg_writing = mean(new_writing_score))
avg_score_by_student

high_scores_by_student <- scores %>% group_by(names) %>% summarise(highest_writing = max(new_writing_score),highest_math = max(adjusted_math_score), highest_science = max(new_science_score))
high_scores_by_student
