# 1. 한빛 25 페이지

# 2. 지니 뮤직 전일 차트 1~100 위 rank, last_rank, title, artist, album
library(rvest)
library(stringr)
library(dplyr)
library(httr)
library(XML)

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
      html_node('.number') %>% 
      html_text()
rank
len <- nchar(rank)
rank <- as.integer(substring(rank, 1, len-504))
rank <- as.integer(rank)
rank

for (i in c(1, 2, 3, 28)){
   tr <- trs[i]
   tds <- html_nodes(tr, 'td') 
   spans <- html_nodes(tds[2], 'span')
   last_str <- html_text(spans[3])
   if (length(spans) == 4) {
      t <- as.integer(html_text(spans[4]))
      if (last_str == 'rank-none') {
         last_rank <- rank
      } else if (last_str == 'rank-up') {
         last_rank <- rank + t
      } else {
         last_rank <- rank - t
      }
   } else {
      last_rank <- 999
   }
}

anchors <- tr %>% 
   html_node('.info') %>% 
   html_nodes('a')
title <- html_text(anchors[2])
artist <- html_text(anchors[3])

title <- tr %>% 
   html_node('.title.ellipsis') %>% 
   html_node('a') %>% 
   html_text()
artist <- tr %>% 
   html_node('.artist.ellipsis') %>% 
   html_node('a') %>% 
   html_text()
   
album <- tr %>% 
   html_node('.albumtitle.ellipsis') %>% 
   html_node('a') %>% 
   html_text()
 
rank_vec <- c()
last_vec <- c()
title_vec <- c()
artist_vec <- c()
album_vec <- c()

for (tr in trs) {
   tr <- trs[i]
   tds <- html_nodes(tr, 'td') 
   spans <- html_nodes(tds[2], 'span')
   last_str <- html_text(spans[3])
   if (length(spans) == 4) {
      t <- as.integer(html_text(spans[4]))
      if (last_str == 'rank-none') {
         last_rank <- rank
      } else if (last_str == 'rank-up') {
         last_rank <- rank + t
      } else {
         last_rank <- rank - t
      }
   } else {
      last_rank <- 999
   }

anchors <- tr %>% 
   html_node('.info') %>% 
   html_nodes('a')
title <- html_text(anchors[2])
artist <- html_text(anchors[3])

title <- tr %>% 
   html_node('.title.ellipsis') %>% 
   html_node('a') %>% 
   html_text()
artist <- tr %>% 
   html_node('.artist.ellipsis') %>% 
   html_node('a') %>% 
   html_text()

album <- tr %>% 
   html_node('.albumtitle.ellipsis') %>% 
   html_node('a') %>% 
   html_text()

rank_vec <- c(rank_vec, rank)
last_vec <- c(last_vec, last_rank)
title_vec <- c(title_vec, title)
artist_vec <- c(artist_vec, artist)
album_vec <- c(album_vec, album)

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
