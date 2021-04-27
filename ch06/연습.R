# 1.
library(dplyr)
library(ggplot2)
library(gapminder)
whole_pop <- gapminder %>% 
   filter(year) %>% 
   select(country, pop) %>% 
   arrange(desc(whole_pop)) %>% 
   head()

pop_whole <-gapminder %>% 
   filter(year) %>%
   for(i in 1:11){
      select(country, pop) %>% 
         arrange(desc(pop)) %>% 
         head()
   }

popYear<- 
for(year in 1952:2007) {
   pop_whole <- 
}

pop_year <- gapminder %>% 
   group_by(year, pop) %>% 
   summarize(c_pop=sum(pop)) %>% 
   head()

head(gapminder)

pop_1952 <-gapminder %>% 
   filter(year== 1952) %>% 
   select(country, pop) %>% 
   arrange(desc(pop)) %>% 
   head()
pie(pop_1952$pop, pop_1952$country)


for(i in 1:11){
   for(j in 1:6){
      pop_whole <- gapminder %>% 
         filter(year) %>% 
         select(country, pop %>% 
                   arrange(desc(pop_whole))) %>% 
         head()
   }
   pie(pop_whole$pop, pop_whole$country)
}d

head(iris)
iris$species, iris$Sepal.Length, iris$Sepal.Width

iris %>% 
   group_by(Species)
   
   plot(iris$Sepal.Length, iris$Petal.Width, main = 'Iris Data Set')
   

gapminder(head)
head(gapminder)


library(dplyr)
library(ggplot2)
library(gapminder)
for(i in 1:12){
   pop_whole <-gapminder %>% 
   filter(year== "(1952+(i-1)*5)") %>% 
   select(country, pop) %>% 
   arrange(desc(pop_whole)) %>% 
   head()
   pie(pop_whole$pop, pop_whole$country)
}

