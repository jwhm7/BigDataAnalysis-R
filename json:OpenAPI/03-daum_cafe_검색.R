# 다음 카페 검색
library(httr)
library(jsonlite)

kakao_api_key <- readLines('OpenAPI/kakao_api_key.txt')
kakao_api_key

base_url <- 'https://dapi.kakao.com/v2/search/cafe'
keyword <- URLencode(iconv('데이터 분석', to= 'UTF-8'))
keyword
query <- paste0('target=title&query=', keyword)
url <- paste(base_url, query, sep= '?')
url

auth_key <- paste('KakaoAK', kakao_api_key)
auth_key
res <- GET(url, add_headers('Authorization'= auth_key))
res
result <- fromJSON(as.character(res))
class(result)                  
df <- as.data.frame(result)
View(df)

write.table(as.matrix(df), 'OpenAPI/book.tsv', row.names = F, sep= '\t')
df2 <- read.csv('OpenAPI/book.tsv',sep= '\t')
View(df2)
