# Exercise 6 과제풀이
library(dplyr)
library(ggplot2)
library(gapminder)

# 단원문제 1-2
for(i in seq(1952, 2007, 5)) {
   print(i)                        # 몇번째에서 에러가 생겼는지 알 수 있음, 윗 문제게 1977 넣어 돌리면 as.numeric쓰라고 나옴.
   x <- gapminder %>% 
      filter(year== i) %>% 
      select(country, pop) %>% 
      arrange(desc(pop)) %>% 
      head()
   pie(as.numeric(x$pop), x$country)
   barplot(x$pop, names.arg=x$country)
   title(i)
}

# 단원문제 2
library(tidyr)

# 단원문제 2-1 airquality       
# 산점도, boxplot, 막대그래프 그릴 때 용이
# ggplot 사용하기 전에도 한 줄로 정리하면 만들기 용이
# gather -> reshape data. data: 읽을 데이터, key: 기존 열 이름을 묶을 새 열이름
# value: 기존 값들을 묶을 새 열이름, -'': 합칠 열 이름
head(airquality)
air_tidy <- gather(airquality, key='Measure', value='Value', 
                   -Day, -Month)
head(air_tidy)
tail(air_tidy)
dim(airquality)
dim(air_tidy)

air_tidy %>% 
   ggplot(aes(Day, Value, col=Measure)) +
   geom_point() +
   facet_wrap(~Month)

# 단원문제 2-2 iris
iris_tidy <- gather(iris, key='feat', value='value',
                    -Species)

head(iris_tidy)
tail(iris_tidy)
iris_tidy %>% 
   ggplot(aes(feat, value, col=Species)) +
   geom_point(position='jitter')    # 겹친 점 알아보기 쉽게 약간의 shake effect

# 연습문제 1
library(gridExtra)
seto <- filter(iris, Species== 'setosa')
vers <- filter(iris, Species== 'versicolor')
virg <- filter(iris, Species== 'virginica')

seto_s <- seto %>% 
   ggplot(aes(Sepal.Length, Sepal.Width, col= Species)) +
   geom_point()
seto_s
seto_p <- seto %>% 
   ggplot(aes(Petal.Length, Petal.Width, col= Species)) +
   geom_point()
seto_p
vers_s <- vers %>% 
   ggplot(aes(Sepal.Length, Sepal.Width, col= Species)) +
   geom_point()
vers_s
vers_p <- vers %>% 
   ggplot(aes(Petal.Length, Petal.Width, col= Species)) +
   geom_point()
vers_p
virg_s <- virg %>% 
   ggplot(aes(Sepal.Length, Sepal.Width, col= Species)) +
   geom_point()
virg_s
virg_p <- virg %>% 
   ggplot(aes(Petal.Length, Petal.Width, col= Species)) +
   geom_point()
virg_p

grid.arrange(seto_s, seto_p, vers_s, vers_p, virg_s, virg_p, ncol=2)        
# 한 화면으로 그래프 싸그리 모으기 = grid.arrange

# 연습문제 1-2
# barplot + legend
seto_mean <- apply(iris[iris$Species== 'setosa', 1:4], 2, mean)
vers_mean <- apply(iris[iris$Species== 'versicolor', 1:4], 2, mean)
virg_mean <- apply(iris[iris$Species== 'virginica', 1:4], 2, mean)
mean_of_iris <- rbind(seto_mean, vers_mean, virg_mean)
mean_of_iris

barplot(mean_of_iris, beside=T,
        main= '품종별 평균', ylim=c(0,8), col=c('red', 'green', 'blue'))
legend('topright',
       legend=c('Setosa', 'Versicolor', 'Virginica'),
       fill=c('red', 'green', 'blue'))

# ggplot
df <- iris %>% 
   group_by(Species) %>% 
   summarize(sepal_length=mean(Sepal.Length), sepal_width=mean(Sepal.Width),
             petal_length=mean(Petal.Length), petal_width=mean(Petal.Width))
df
df_tidy <- gather(df, key='Feature', value='Value', -Species)
df_tidy
ggplot(df_tidy, aes(x=Feature, y=Value, fill=Species)) +
   geom_bar(stat= 'identity')

ggplot(df_tidy, aes(x=Feature, y=Value, fill=Species)) +
   geom_bar(stat= 'identity', position='dodge')
# fill은 막대 안의 색, color은 겉 테두리

# 3-3
# boxplot
# par를 쓰면 그림이 같이 그려짐. 사용 후에는 default(par(mfrow=c(1,1)))
par(mfrow=c(3,1))      # 3행 1열의 그래프를 그려라
boxplot(seto$Sepal.Length, seto$Sepal.Width,
       seto$Petal.Length, seto$Petal.Width, 
       col=c('red', 'green', 'blue'),
       name=c('Sepal.Length', 'Sepal.Width', 'Petal.Length', 'Petal.Width'),
       main='Setosa')
boxplot(vers$Sepal.Length, vers$Sepal.Width,
        vers$Petal.Length, vers$Petal.Width, 
        col=c('red', 'green', 'blue'),
        name=c('Sepal.Length', 'Sepal.Width', 'Petal.Length', 'Petal.Width'),
        main='Versicolor')
boxplot(virg$Sepal.Length, virg$Sepal.Width,
        virg$Petal.Length, virg$Petal.Width, 
        col=c('red', 'green', 'blue'),
        name=c('Sepal.Length', 'Sepal.Width', 'Petal.Length', 'Petal.Width'),
        main='Virginica')
par(mfrow=c(1,1))

# ggplot - 사용 시 tidy 사용
seto_tidy <- gather(seto, key='Feature', value='Value', -Species)
head(seto_tidy)
s1 <- ggplot(seto_tidy, aes(x=Feature, y=Value, col=Feature)) +
   geom_boxplot() +
   ggtitle('Setosa')
s1
vers_tidy <- gather(vers, key='Feature', value='Value', -Species)
head(vers_tidy)
s2 <- ggplot(vers_tidy, aes(x=Feature, y=Value, col=Feature)) +
   geom_boxplot() +
   ggtitle('Versicolor')
s2
virg_tidy <- gather(virg, key='Feature', value='Value', -Species)
head(virg_tidy)
s3 <- ggplot(virg_tidy, aes(x=Feature, y=Value, col=Feature)) +
   geom_boxplot() +
   ggtitle('Virginica')
s3
grid.arrange(s1, s2, s3, ncol=1)
