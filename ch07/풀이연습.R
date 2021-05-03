library(dplyr)
galton <-read.table('data/Galton.txt', header = T)
galton
head(galton)

df <- galton %>% 
   filter(Gender== 'M') %>% 
   select(Father, Height)
head(df)

df_m <- df %>% 
   mutate(father= Father*2.54, son= Height*2.54)
head(df_m)

plot(df)
model <- lm(son ~ father, data= df_m)
coef(model)
abline(model, col= 'red', lwd =3)

