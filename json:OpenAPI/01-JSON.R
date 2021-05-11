#  JASON 기본 (내장 데이터 처리)
library(jsonlite)

pi
json_pi <- toJSON(pi, digits= 3)
json_pi
fromJSON(json_pi)

city <- '대전'
json_city <- toJSON(city)
json_city
fromJSON(json_city)

subject <- c('국어', '영어', '수학')
json_subject <- toJSON(subject)
json_subject
fromJSON(json_subject)

# Data frame
name <- c("Test")
age <- c(25)
sex <- c("F")
address <- c("Seoul")
hobby <- c("Basketball")
person <- data.frame(Name= name, Age= age, Sex= sex,
                     Address= address, Hobby= hobby)
str(person)
json_person <- toJSON(person)
json_person
prettify(json_person)

# ====================================================
df_json_person <- fromJSON(json_person)
str(df_json_person)

# 두새의 데이터프레임의 데이터 값이 같은지 비교
all(person== df_json_person)

# cars 내장 데이터로 테스트
cars
json_cars <- toJSON(cars)
prettify(json_cars)
df_json_cars <- fromJSON(json_cars)
all(cars== df_json_cars)

# JSON 파일로 부터 읽어서 데이터프레임 만들기
library(jsonlite)

# person.json 파일로 부터 읽기
wiki_person <- fromJSON("OpenAPI/person.json")
str(wiki_person)
class(wiki_person)
wiki_person

# sample.json
data <- fromJSON('OpenAPI/sample.json')   # JSON 파일 읽기
str(data)

data <- as.data.frame(data)
names(data) <- c('id', 'like', 'share', 'comment', 'unique', 'msg', 'time')
data$like <- as.numeric(as.character(data$like))
View(data)

# CSV파일로 저장
write.csv(data, 'OpenAPI/data.csv')

# Data Frame을 JSON파일로 저장
json_Data <- toJSON(data)
write(json_data, 'data.json')
prettify(json_Data)

# Converting JSON to R DataFrame
df_repos <- fromJSON("https://api.github.com/users/hadley/repos")
str(df_repos)
names(df_repos)

names(df_repos$owner)
