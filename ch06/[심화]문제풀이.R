library(dplyr)
library(ggplot2)

# 1.
head(mpg)
ggplot(mpg, aes(cty, hwy, col= class)) +       # col= class를 해서 색칠하기
   geom_point(potision= 'jitter')

# 2.
head(midwest)
mw <- midwest %>% 
   filter(poptotal <= 500000 & popasian <= 10000)
options(scipen = 10)      # 지수 표기를 일반 표기로 변환
ggplot(mw, aes(x= poptotal, y= popasian, col= state)) +
   geom_point() +
   xlim(0, 500000) + ylim(0, 10000)
# 연결해서 한번에 실행하기, 스케일 변화
midwest %>% 
   filter(poptotal <= 500000 & popasian <= 10000) %>% 
   ggplot(aes(x= poptotal, y= popasian, col= state)) +
   geom_point() +
   scale_x_log10() + scale_y_log10()

# 3. (실행시켜보기)
df_suv <- mpg %>% 
   filter(class== 'suv') %>% 
   group_by(manufacturer) %>% 
   summarize(mean_cty= mean(cty)) %>% 
   arrange(desc(mean_cty)) %>% 
   head(5) %>% 
   ggplot(aes(x= reorder(manufacturer, -mean_cty), y= mean, 
                   fill= manufacturer)) +
   geom_col() +      # geom_bar는 stat='identity'를 써야 하지만 얘는 안그래도 됨
   labs(x= 'Manufacturer', y= 'average cty')

# 4.
mpg %>% 
   group_by(class) %>% 
   summarize(count= n()) %>% 
   ggplot(aes(x= reorder(class, -count), y= count, fill=class)) +
   geom_col() +
   labs(x= 'Class')

# 5.
head(economics)
ggplot(economics, aes(date, psavert)) +
   geom_line()

head(economics)
ggplot(economics) +
   geom_line(aes(date, psavert, col= psavert))

# 6.
mpg %>% 
   filter(class %in% c("compact", "subcompact", "suv")) %>% 
   ggplot(aes(x= class, y= cty, col= class)) +
   geom_boxplot()

# 7.
head(diamonds)
str(diamonds)

# 7-1.
diamonds %>% 
   group_by(cut) %>% 
   summarize(count=n()) %>% 
   ggplot(aes(cut, count, fill= cut)) +   # 위치인수는 = 빼도 되고 키워드형 인수는 안됨.
   geom_col()
# 또는 
ggplot(diamonds, aes(x= cut, fill= cut)) +
   geom_bar()

# 7-2.
diamonds %>% 
   group_by(cut) %>% 
   summarize(mean_price= mean(price)) %>% 
   ggplot(aes(cut, mean_price, fill= cut)) +
   geom_col()

# color에 따른 가격의 변화
diamonds %>% 
   group_by(color) %>% 
   summarize(mean_price= mean(price)) %>% 
   ggplot(aes(color, mean_price, fill= color)) +
   geom_col()

# cut, color에 따른 돗수 분포
ggplot(diamonds, aes(x= price)) +
   geom_histogram(bins= 5) +
   facet_wrap(~cut + color)

# cut이 'Fair'인 경우, color에 따른 가격의 변화
df_cut_fair <- diamonds %>% 
   filter(cut== 'Fair') %>% 
   group_by(color) %>% 
   summarize(mean_price= mean(price))
g_fair <- ggplot(df_cut_fair, aes(x= color, y= mean_price, fill= color)) +
   geom_col() +
   ggtitle('Cut = Fair') +
   theme(plot.title = element_text(face= "bold", size= 16, vjust= 1, color= "red"))

# 나머지는 git 참고

# 한방에
diamonds %>% 
   group_by(cut, color) %>% 
   summarize(avg_price= mean(price)) %>% 
   ggplot(aes(cut, avg_price, fill= color)) +
   geom_bar(stat='identity', position='dodge')

diamonds %>% 
   group_by(cut, color) %>% 
   summarize(avg_price= mean(price)) %>% 
   ggplot(aes(color, avg_price, fill= cut)) +
   geom_col(position='dodge')
