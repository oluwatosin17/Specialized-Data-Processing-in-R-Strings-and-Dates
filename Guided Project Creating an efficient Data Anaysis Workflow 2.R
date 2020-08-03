---
  
  title: "Guided Project: Creating An Efficient Data Analysis WorkFlow"
author: "Tosin"
date: "7/31/2019"
output: html_document
---
library(readr)
library(tidyverse)
sales <- read_csv("sales2019.csv")
view(sales)

#How big is the dataset?
dim(sales)
# We have 5000 rows and 5 columns

#What are the column names
colnames(sales)
#What are the types of each columns

for(n in colnames(sales)){
  print(typeof(sales[[n]]))
}

for(n in colnames(sales)){
  print(sum(is.na(sales[n])))
}

#We have 885 missing values in the user_submitted_review column and 718 missing values in the total_purchased column

sales1 <- sales %>% filter(!(is.na(sales[["user_submitted_review"]])))
for(n in colnames(sales1)){
  print(sum(is.na(sales1[n])))
}


sales1$total_purchased()

#The remaining missing values for the total_purchased column is 583

total_purchased_mean <- mean(sales1[["total_purchased"]],na.rm = T)
total_purchased_mean


view(sales1)
sales1 <- sales1 %>% mutate(updated_total_purchased = if_else(is.na(total_purchased), 
                                                              total_purchased_mean,
                                                              total_purchased))



#Processing Review Data
sales1$user_submitted_review[[1]]      
unique(sales1$user_submitted_review)

reviews <- function(string){review = case_when(
  str_detect(string,"ok") ~ "Positive",
  str_detect(string,"Awesome") ~ "Positive",
  str_detect(string,"I learned a lot")~ "Positive",
  str_detect(string,"Never read ")~ "Positive",
  str_detect(string,"OK")~ "Positive", 
  T ~ "Negative"
  )
return(review) 
}

sales1 <- sales1 %>% mutate(ratings = unlist(map(user_submitted_review,reviews)))  
view(sales1)

example_tibble <- tibble(
  group = c(1,1,1,1,2,2,2,2),
  value = c(1,2,3,4,5,6,7,8)
)
example_summary_table <- example_tibble %>% group_by(group) %>% summarise(sum_of_values = sum(value))
example_summary_table

library(lubridate)


min(sales[['date']])
sales1 <- sales1 %>% mutate(ordered_date = if_else(ymd(date) < ymd("2019-07-01"),"before","after"))

sales_summary0 <- sales1%>% group_by(ordered_date) %>% summarise(sum_of_vales = sum(updated_total_purchased))
sales_summary0
#There was a decrease in sales of books after.

sales_summary <- sales1%>% group_by(ordered_date, title) %>% summarise(sum_of_vales = sum(updated_total_purchased))%>% arrange(title)
sales_summary

#There was a decrease in the purchase of three books and also an increase in the purchase three books. We can see from the summary that "Fundamentals of R for beginners","R vs Python","Top 10 Mistakes R Beginners Make" decreased in the number of books sold 

customer_sales_summary <- sales1%>% group_by(ordered_date, customer_type) %>% summarise(sum_of_vales = sum(updated_total_purchased))
customer_sales_summary
#There was an increase in the purchase of books by businesses after the program ,with a drrop in the individual sales


summary_reviews <- sales1 %>% group_by(ordered_date, ratings) %>% summarize((numberofreviews =  n()))
summary_reviews

#There was an increase in the negative reviews after the program started and slight drop in the positive reviews

