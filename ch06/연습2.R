iris %>% 
   filter(Species== 'Setosa') %>% 
   ggplot(aes(reorder(Sepal.Length, Sepal.Width), ))

iris_Se <-iris %>% 
   filter(Species== 'Setosa') %>% 
   select(Petal.Length, Petal.Width)
plot(iris_Se$Petal.Width, iris_Se$Petal.Length)

plot(iris$Petal.Length, iris$Petal.Width)

iris_Se <- iris %>% 
   select(Species== 'Setosa')
iris_Se <- iris %>% 
   filter(Species== 'setosa')
plot(iris_Se$Petal.Width, iris_Se$Petal.Length, main= 'Setosa Data Set- Petal')

iris_se <- iris %>% 
   filter(Species== 'setosa')
plot(iris_se$Petal.Width, iris_se$, main= 'Setosa Data Set- Petal')


head(iris)
