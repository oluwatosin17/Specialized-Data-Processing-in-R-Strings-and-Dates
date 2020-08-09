# Specialized-Data-Processing-in-R-Strings-and-Dates


## String Manipulation in R: 

> str_sub()

enables us to index strings:

> str_to_lower()

enables us to change all of the letters to lowercase in a given string:
 
> str_to_upper()

enables us to change all of the letters to uppercase in a given string:
 
> str_pad()

helps with padding strings, while

> str_trim()

lets us trim whitespace or other designated characters from strings: ` padded_string <- " Dataquest " str_trim(padded_string, side = "both") [1] "Dataquest"

`str_pad("Dataquest", width = 20, side = "both", pad = " ")`


> str_split()

allows us to split a character vector into smaller substrings by splitting on a given character such as a single whitespace: 

`str_split(sentence, " ")`

> str_c()

allows us to concatenate, or combine, strings together:

`words <- c("String", "concatentation", "via", "function")
    str_c(words, collapse = " ")
    [1] "String concatentation via function"`

> str_detect()

allows us to check if a particular substring is contained within a greater string: 

`review <- "I really enjoyed this product, and I thought it was great for the price."
str_detect(review, "great") [1] TRUE`

> str_replace()

lets us exchange the first instance of a given substring with another: 

`review2 <- "I really enjy codnig in R and wnt to lrn more."
str_replace(review2, pattern = "enjy", replacement = "enjoy") [1] "I really enjoy codnig in R and wnt to lrn more."`

> str_replace_all()

lets us exchange all instances of a substring with another:
 
`review3 <- "I want to lrn R, and I definitely wnt to lrn more."
str_replace_all(review3, pattern = "lrn", replacement = "learn") [1] "I want to learn R, and I definitely wnt to learn more."`

## Date and Time Manipulation in R: Fundamentals

Dates and times can be created using the following family of functions:

`date1 <- "20/04/21"
ymd(date1)
[1] "2020-04-21"` 
date2 <- "04-21-20"
mdy(date2)
[1] "2020-04-21"`
ymd_hms(date1)
[1] "2020-04-21 13:30:00 UTC"`

You can extract different parts of a date using functions named after the component you want to extract:

`year(date1)
[1] 2020
month(date2)
[1] 4`

You can also extract the day of the week and the day of the year with other functions:
`day(date1) # Day of the month
[1] 21
wday(date1, label = TRUE) # Day of the week
[1] Tue
yday(date1) # Day of the year
[1] 112`

You can represent time spans using either Durations or Periods:

`dur <- duration(day = 1, hour = 1, minute = 30)
per <- period(years = 1, months = 1, days = 1)`

You can convert timezones using the following function:

`with_tz(date1, tz = "America/Los_Angeles")`



## The Map Function in R

> Creating a custom function and using map() to vectorize it

 `format_score <- function(score) { fmt_string <- str_replace(score, "%", "") num <- as.numeric(fmt_string)
return(num) }
example_scores <- c("19%", "81%", "100%")
map_result <- map(example_scores, format_score)`

> Using map2() to vectorize a function that takes in two inputs 

`first_inputs <- c(1, 2, 3) second_inputs <- c(4, 5, 6)
add_inputs <- function(x, y) { return(x + y) }
output <- map2(first_inputs, second_inputs, add_inputs)`

> Using the map() and mutate() functions to create a new column in your dataset

 `format_score <- function(score) { fmt_string <- str_replace(score, "%", "") num <- as.numeric(fmt_string)
return(num) }
scores <- scores %>% mutate( new_writing_score = unlist(map(writing_score, format_score)) )`

> Using lists as an input to the map() function 

`input_list <- list( c(1, 2), c(3, 4), c(5, 6), c(7, 8), c(9, 10) )
output <- map(input_list, sum)`

> Using group_by() and summarize() together to vectorize a summary function across groups in a dataset

`avg_score_by_student <- student_scores %>%
      group_by(names) %>%
      summarize(
        avg_writing = mean(new_writing_score)
      )`
