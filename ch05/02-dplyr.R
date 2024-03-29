# dplyr 라이브러리를 이용한 데이터 가공
# filter, select, arrange, group_by&summarize, mutate
# %>% (chain/pipe)
library(dplyr)
library(gapminder)

# 1. select - 원하는 열을 추출
select(gapminder, country, year, lifeExp)
select(gapminder, country, year, lifeExp) %>% head()
select(gapminder, country, year, lifeExp) %>% head(10)

# 2. filter - 원하는 행을 추출
filter(gapminder, country=='Croatia')
filter(gapminder, country=='Croatia'&year>2000)
filter(gapminder, continent=='Europe'&year==2007)

# 3. arrange - 정렬, 디폴트는 오름차순
europe_pop <- filter(gapminder, continent=='Europe'&year==2007)
arrange(europe_pop, lifeExp)
arrange(europe_pop, desc(lifeExp))  # 내림차순
# 아프리카 대륙에서 평균 구명이 가장 긴 나라 Top 5
africa_pop <-filter(gapminder, continent=='Africa'&year==2007)
arrange(africa_pop, desc(lifeExp)) %>% head(5)

filter(gapminder, continent=='Africa'&year==2007) %>%
    arrange(desc(lifeExp)) %>% 
    head(5)
# 일반적으로 많이 사용하는 방법
gapminder %>%
    filter(continent=='Africa'&year==2007) %>%
    arrange(desc(lifeExp)) %>% 
    head(5)

# 4. group_by&summarize
summarize(africa_pop, pop_avg=mean(pop))  # 2007년 아프리카 국가별 평균 인구 수
summarize(group_by(gapminder, continent), pop_avg=mean(pop))
summarize(group_by(gapminder, country), life_avg=mean(lifeExp))

asia_pop <- gapminder %>%
    filter(continent=='Asia')
summarize(group_by(asia_pop, country), life_avg=mean(lifeExp))
summarize(group_by(asia_pop, country), life_avg=mean(lifeExp)) %>% 
    arrange(desc(life_avg)) %>%
    head(5)

# mpg(mile-per-gallon)
library(ggplot2)
head(mpg)
glimpse(mpg)
summary(mpg)

# 통합연비 변수
mpg$total <- (mpg$cty + mpg$hwy)/2
head(mpg)
mean(mpg$total)
summary(mpg$total)
hist(mpg$total)

# 평균연비가 20 이상이면 합격, 아니면 불합격
mpg$test <- ifelse(mpg$total>=20, 'pass', 'fail')
table(mpg$test)
qplot(mpg$test)

# 평균연비가 30 이상이면 A등급, 20이상이면 B등급, 아니면 C등급
mpg$grade <- ifelse(mpg$total>=30, 'A',
                    ifelse(mpg$total>=20, 'B', 'C'))
table(mpg$grade)
qplot(mpg$grade)

gapminder %>% 
    filter(continent=='Asia') %>%
    group_by(country) %>%
    summarize(life_avg=mean(lifeExp)) %>%
    arrange(desc(life_avg)) %>%
    head(5)
# 2007년 인구수 5000만 이상인 국가 중 기대 수명이 가장 큰 Top5 국가
gapminder %>%
    filter(year==2007 & pop>=5e7) %>%
    group_by(country) %>%
    summarize(life_avg=mean(lifeExp)) %>%
    arrange(desc(life_avg)) %>%
    head(5)

# 5. mutate - 새로운 변수 추가
mpg %>%
    mutate(grade2=ifelse(mpg$total>=30, 'A',
                         ifelse(mpg$total>=20, 'B', 'C')))
mpg <- mpg %>% 
    mutate(grade2=ifelse(mpg$total>=30, 'A',
                         ifelse(mpg$total>=20, 'B', 'C')))
table(mpg$grade2)
