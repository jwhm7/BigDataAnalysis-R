# dplyr 연습문제 풀이
# 1.
library(dplyr)
mpg <- as.data.frame(ggplot2::mpg)
mpg %>%
  mutate(displ45= ifelse(displ<=4, 'DISPL4', 'DISPL5')) %>%
  group_by(displ45) %>%
  summarize(avg_hwy=mean(hwy)) %>%
  arrange(desc(avg_hwy))

# 2. 
mpg %>%
  group_by(manufacturer) %>%
  summarize(avg_cty=mean(cty)) %>%
  arrange(desc(avg_cty))

# 3.
mpg %>%
  filter(manufacturer %in% c('chevorlet', 'ford', 'honda')) %>%
  summarize(avg_hwy-mean(hwy))
  
# 4.
  mpg4<- mpg %>%
  select(class, cty)
head(mpg4)  
  
# 7.
# (4) 
mpg %>%
  mutate(total=cty+hwy, avg=total/2) %>%
  arrange(desc(avg)) %>%
  head(3)

# 11.
mpg %>%
  filter(class=='compact') %>%
  group_by(manufacturer) %>%
  summarize(num_kind=n()) %>%   # n()- 행의 갯수
  arrange(desc(num_kind))
