# 단원문제 1 -2
library(dplyr)
library(ggplot2)
library(gapminder)

# 방법1. 시퀀스 벡터 사용
year_e <- seq(from = 1952,to = 2007, by = 5)
for(i in 1:12){
   pop_e<- gapminder %>% 
      filter(year == year_e[i]) %>%
      arrange(desc(pop)) %>% 
      head()
   pie(as.numeric(pop_e$pop), as.numeric(pop_e$country), main = year_e[i])
   barplot(pop_e$pop, names.arg=(pop_e$country), main = year_e[i])
}

# 방법2. loop_cnt 사용 -> 입력 값만 바꿔서 활용 가능.
loop_cnt = (2007-1952)/5+1
for(i in 1:loop_cnt){
   a=1952+(i-1)*5 
   pop_e <- gapminder %>% 
      filter(year == a) %>%
      arrange(desc(pop)) %>% 
      head()
   pie(as.numeric(pop_e$pop), as.numeric(pop_e$country), main = a)
   barplot(pop_e$pop, names.arg = (pop_e$country), main = a)
}

# 방법3. for문, 함수 지정 -> 단점: 다른 변수에는 적용 어려움
for(i in 1:12){
   a=1952+(i-1)*5 
   pop_e <- gapminder %>% 
      filter(year == a) %>%
      arrange(desc(pop)) %>% 
      head()
   pie(as.numeric(pop_e$pop), as.numeric(pop_e$country), main = a)
   barplot(pop_e$pop, names.arg = (pop_e$country), main = a)
}


# 연습문제 1
iris_se <- iris %>% 
   filter(Species== 'setosa')
   ggplot(iris_se,aes(Sepal.Length, Sepal.Width)) +
   geom_point()+
      ggtitle('Setosa-Sepal')