## install packages
install.packages("dplyr")

## load library ตอนจะใช้ ใช้คำสั่งว่า
library(dplyr)

## read csv file intro RStudio
imdb <- read.csv("imdb.csv", stringsAsFactors = FALSE)
View(imdb)
 

library(readr)
imdb <- read_csv("Desktop/R programming course/imdb.csv")
View(imdb)

## Review data structure
glimpse(imdb)


## print head and tail of data 
head(imdb, 10)
tail(imdb, 10)


## select column
select(imdb, MOVIE_NAME, RATING)
select(imdb, 1, 5)

select(imdb, movie_name = MOVIE_NAME, released_year = YEAR)

## pipe operator
imdb %>%
  select(movie_name = MOVIE_NAME, released_year = YEAR) %>%
  head(10)

## Filter data
filter(imdb, SCORE >= 9.0)

imdb %>% filter(SCORE >= 9.0)


names(imdb) <- tolower(names(imdb))

imdb %>%
  select(movie_name, year, score) %>%
  filter(score >=9  & year >2000)

imdb %>%
  select(movie_name, length, score) %>%
  filter(score == 8.8 | score == 8.3 | score == 9.0)

imdb %>%
  select(movie_name, length, score) %>%
  filter(score %in% c(8.3, 8.8, 9.0))


## Filter string column
imdb %>%
   select(movie_name, genre, rating) %>%
  filter(grepl("Drama", imdb$genre))

imdb %>%
  select(movie_name, genre, rating) %>%
  filter(grepl("King", imdb$movie_name))
imdb %>%
  select(movie_name, genre, rating) %>%
  filter(grepl("king", imdb$movie_name))




## Create new column
imdb %>%
   select(movie_name, score, length) %>%
   mutate(score_group = if_else(score >= 9, "High Rating", "Low Rating"),
          legth_group = if_else(length >= 120, "Long Film", "Short Film"))


imdb %>%
  select(movie_name, score) %>%
  mutate(score_update = score + 0.1) %>%
  head(10)

imdb %>%
  select(movie_name, score) %>%
  mutate(score = score + 0.1) %>%
  head(10)


## arrange data
head(imdb)

imdb %>%
  arrange(length) %>%
  head(10)

imdb %>%
  arrange(desc(length)) %>%   #descending order
  head(10)

imdb %>%
  arrange(rating,desc(length)) %>%   
  head(10)
#---------------------------------------------------#

## Summarise and group_by
imdb %>%
  group_by(rating) %>%
  summarise(mean_length = mean(length),
            sum_length = sum(length),
            sd_length = sd(length),
            min_length = min(length),
            max_length = max(length),
            n = n())

imdb %>%
  filter(rating != "") %>%
  group_by(rating) %>%
  summarise(mean_length = mean(length),
             sum_length = sum(length),
             sd_length = sd(length),
             min_length = min(length),
             max_length = max(length),
             n = n())
          


## Join data

favorite_film <- data.frame(id = c(5,10,25,30,98))

favorite_film %>%
  inner_join(imdb, by = c("id" = "no"))

## write csv file (export result)
imdb_prep <- imdb %>%
  select(movie_name, released_year = year, rating, length, score) %>%
  filter(rating == "R" & released_year > 2000)

## export file
write.csv(imdb_prep, "imdb_prep.csv", row.names = FALSE)












