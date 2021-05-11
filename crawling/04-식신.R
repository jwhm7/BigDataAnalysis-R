# 식신 한남대 크롤링
library(rvest)
library(stringr)
library(dplyr)

base_url <- 'https://www.siksinhot.com'
path <- '/search'
place <- '한남대'
query <- paste0('?keywords=', 
url <- paste0(base_url, query, place)
html <- read_html(url)

lis <- html %>% 
   html_node('dic.listTy1') %>% 
   html_nodes('ul li')
name
