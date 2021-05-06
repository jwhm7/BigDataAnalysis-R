# Alice data
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
alice <- readLines('data/Alice.txt')

docs <- Corpus(VectorSource(alice))

docs <- tm_map(docs, stripWhitespace)
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, removeWords, stopwords("english"))
docs <- tm_map(docs, removePunctuation)

dtm <- DocumentTermMatrix(docs)
dim(dtm)
inspect(dtm)

m <- as.matrix(dtm)
v <- sort(colSums(m), decreasing = T)
v[1:5]
df <- data.frame(word= names(v), freq= v)
head(df)


library(wordcloud2)
library(htmlwidgets)
library(htmltools)
library(jsonlite)
library(yaml)    
library(base64enc)    

wordcloud2(df, figPath = 'data/Alice_mask.png', size = 1)

