# Galton 선형회귀
library(dplyr)
library(ggplot2)

df <- read.csv('http://www.randomservices.org/random/data/Galton.txt', sep='\t')

# 아버지와 아들의 키
galton <- df %>% 
   filter(Gender== 'M') %>% 
   mutate(father= 2.54*Father, son= 2.54*Height)

model <- lm(son~father, data= galton)
coef(model)
ggplot(galton, aes(father, son)) +
   geom_point(position= 'jitter', color= 'darkorange') +
   geom_abline(intercept=coef(model), slope = coef(model)[1], slope=coef(model)[2],
               color='darkblue', size=1)
summary(model)
par(mfrow=c(2,2))
plot(model)
par(mfrow=c(1,1))

# pvalue가 낮다. 제대로 된 갑. 근데 r squred is only 0.13. so it is a correct model, but not a great one. 
# 잔차분석 : 데이터가 한쪽에 있지않고 퍼져있고 등등 이것도 쓰기. 아까 찾았던 사이트에서 하면 될 듯.

# 다차식 회귀를 해보고 anova에 나온 pvalue가 의미가 없다는걸 이야기. --> 보고서쓰기.