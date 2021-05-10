# 1. 한빛 25 페이지

for(i in c(1, 2, 3, 28)){
   tr <- trs[1]
   tds <- html_nodes(tr, 'td') 
   spans <- html_nodes(tds[2], 'span')
   spans
   last_str <- html_text(spans[4])
   last_str
   if (length(spans) == 3) {
      t <- as.integer(html_text(spans[3]))
      if (last_str == '유지') {
         last_rank <- rank
      } else if (last_str == '상승') {
         last_rank <- rank + t
      } else if (last_str== '하강') {
         last_rank <- rank - t
      } else {
      last_rank <- 999
   }
}

# 2. 지니 뮤직 전일 차트 1~100 위 rank, last_rank, title, artist, album
library(rvest)
library(stringr)
library(dplyr)
library(httr)

url <- 'https://www.genie.co.kr/chart/top200?ditc=D&rtm=N'
html <- read_html(url)

trs <- html %>% 
   html_node('.newest-list') %>% 
   html_node('.music-list-wrap') %>% 
   html_nodes('table') %>% 
   html_nodes('tbody') %>% 
   html_nodes('tr')
trs

tr <- trs[1]
rank <- tr %>% 
      html_node('td.number') %>% 
      html_text()
gsub('\n','',rank)
len <- nchar(rank)
rank <- as.integer(substring(rank, 1, len-504))
rank <- as.integer(rank)
rank

rank_vec <- c()
last_vec <- c()
title_vec <- c()
artist_vec <- c()
album_vec <- c()

for (tr in trs) {
   tr <- trs[i]
   tds <- html_nodes(tr, 'td') 
   spans <- html_nodes(tds[2], 'span')
   spans
   last_str <- html_text(spans[3])
   last_str
   if (length(spans) == 3) {
      t <- as.integer(html_text(spans[3]))
      if (last_str == '상승') {
         last_rank <- rank
      } else if (last_str == '하강') {
         last_rank <- rank + t
      } else {
         last_rank <- rank - t
      }
   } else {
      last_rank <- 999
   }

title <- tr %>% 
   html_node('a.title.ellipsis') %>% 
   html_text()
str_trim(title, side= 'left')

artist <- tr %>% 
   html_node('a.artist.ellipsis') %>% 
   html_text()
str_trim(artist, side= 'left')

album <- tr %>% 
   html_node('a.albumtitle.ellipsis') %>% 
   html_text()
str_trim(album, side= 'left')

rank_vec <- c(rank_vec, rank)
last_vec <- c(last_vec, last_rank)
title_vec <- c(title_vec, title)
artist_vec <- c(artist_vec, artist)
album_vec <- c(album_vec, album)
}

week_chart <- data.frame(
rank=rank_vec, last_rank=last_vec, title=title_vec,
artist=artist_vec, album=album_vec
)      
View(week_chart)
