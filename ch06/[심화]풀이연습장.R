library(dplyr)
library(ggplot2)
mpg <- ggplot2::mpg
mpg

## 1. mpg 데이터의 cty(도시 연비)와 hwy(고속도로 연비) 간에 
# 어떤 관계가 있는지 알아보려고 합니다. 
# x축은 cty, y축은 hwy로 된 산점도를 만들어 보세요.

# 산점도 -> geom_point()
mpg
ggplot(data= mpg, aes(x=cty, y=hwy))+
   geom_point(col="blue")

##2. 미국 지역별 인구통계 정보를 담은 ggplot2 패키지의 
# midwest 데이터를 이용해서 전체 인구와 아시아인 인구 간에 어떤 관계가 있는지 
# 알아보려고 합니다. x축은 poptotal(전체 인구), y축은 popasian(아시아인 인구)으로
# 된 산점도를 만들어 보세요. 
# 전체 인구는 50만 명 이하, 아시아인 인구는 1만 명 이하인 지역만 산점도에
# 표시되게 설정하세요. 
# -> xlim, ylim: 값에 제한두기
midwest
ggplot(data= midwest, aes(x= poptotal, y= popasian)) +
   geom_point(col='blue') +
   xlim(0, 500000) +
   ylim(0, 10000)


## 3. 어떤 회사에서 생산한 "suv" 차종의 도시 연비가 높은지 알아보려고 합니다. 
# "suv" 차종을 대상으로 평균 cty(도시 연비)가 가장 높은 회사 다섯 곳을 
# 막대 그래프로 표현해 보세요. 막대는 연비가 높은 순으로 정렬하세요. 

# ggplot 사용시 입력 순서 -> ggplot(data= , aes(x,y)) + geom_
# 순서대로 정렬하고 싶으면 reorder을 사용하는데, reorder의 x는 group_by한것, summarize한것. y는 summarize한 것.
# reorder의 순서 방향 바꾸는건, reorder의 x의 y부분에 -를 붙이고 떼는걸로 조절.
# 도시연비: cty
# class: 'suv'
suv_cty <- mpg %>% 
   filter(class== 'suv') %>% 
   group_by(manufacturer) %>% 
   summarize(mean_cty=mean(cty)) %>% 
   arrange(desc(mean_cty)) %>% 
   head()
ggplot(data= suv_cty, aes(reorder(manufacturer, -mean_cty), y= mean_cty)) +
   geom_bar(stat='identity', aes(fill= manufacturer)) +
   labs(x= 'manufacturer',
        y= 'mean_cty',
        title= '회사별 SUV의 도시 연비'
        )

# 4. 자동차 중에서 어떤 class(자동차 종류)가 가장 많은지 알아보려고 합니다. 
# 자동차 종류별 빈도를 표현한 막대 그래프를 만들어 보세요.

# 자동차 종류= class
# 빈도 막대 그래프는 값의 빈도(개수)로 막대의 길이를 표현한다 
# 따라서 y 축 없이 x 축만 지정하고, geom_bar()를 사용하면 된다. 
# x 축 변수의 항목별 빈도 막대 그래프가 출력된다.
ggplot(data= mpg, aes(x= class)) +
   geom_bar(aes(fill= class)) +
   labs(x= 'class',
        y= 'number',
        title= '자동차 종류별 빈도')

## 5. economics 데이터를 이용해서 psavert(개인 저축률)가 시간에 따라서 어떻게 
# 변해왔는지 알아보려고 합니다. 
# 시간에 따른 개인 저축률의 변화를 나타낸 시계열 그래프를 만들어 보세요.

# 시계열 그림(Time Series Graph): 시간에 따른 자료의 변화나 추세를 파악하는데 적절. (line graph, geom_line())
# -> x축에 시간에 대한 데이터를 넣는 것이 포인트
ggplot(data= economics, aes(x= date, y= psavert)) +
   geom_line(color="blue") +
   ggtitle('Time Series Graph, Personal Saving Rate')

## 6. class(자동차 종류)가 "compact", "subcompact", "suv"인 자동차의 
# cty(도시 연비)가 어떻게 다른지 비교해보려고 합니다. 
# 세 차종의 cty를 나타낸 상자 그림을 만들어보세요.

# 상자 그림 -> geom_boxplot()
# tidy해서 만들기..? --> no need
# 벡터 내 특정 값 포함 여부 확인 연산자 %in%, The %in% operator in R 
# can be used to identify if an element (e.g., a number) belongs to a vector or dataframe. 
# For example, it can be used the see if the number 1 is in the sequence of numbers 1 to 10.
mpg_c <- mpg %>% 
   filter(class %in% c('compact', 'subcompact', 'suv'))
ggplot(data= mpg_c, aes(x= class, y= cty)) +
   geom_boxplot(color=c('red', 'green', 'blue'))

# boxplot 기본함수로 그리기 -> ggplot이 더 다양한 방식으로 그래프를 확장시켜나갈 여지가 많음.
compact <- mpg %>% 
   filter(class== 'compact')
subcompact <- mpg %>% 
   filter(class== 'subcompact')
suv <- mpg %>% 
   filter(class=='suv')
boxplot(compact$cty, subcompact$cty, suv$cty)

## 7. 7. Diamonds 데이터 셋을 이용하여 다음 문제를 해결하세요. 
# 단, 컬러, 제목, x축, y축 등 그래프를 예쁘게 작성하세요.
diamonds
# (1) cut의 돗수를 보여주는 그래프를 작성하세요.
# 해당 cut quality의 개수가 몇개인지. -> 빈도수 막대그래프는 ㅛ축을 비워놓는다.
?diamonds
ggplot(data= diamonds, aes(x= cut)) +
   geom_bar(aes(fill= cut))+
   scale_fill_brewer(palette = "Blues") +
   labs(x= 'no. of diamonds',
        y= 'cut quality',
        title = "Cut Quality에 따른 Diamonds 개수")

## (2) cut에 따른 가격의 변화를 보여주는 그래프를 작성하세요.
# geom_bar -> 평균 가격을 구해서 막대그래프로 쌱 그려라
library(dplyr)
library(ggplot2)
m_price<- diamonds %>% 
   group_by(cut) %>%
   summarize(mean_price=mean(price))
m_price
ggplot(data= m_price, aes(x= cut, y= mean_price)) +
   geom_bar(stat = 'identity', aes(fill=cut)) +
   scale_fill_brewer(palette = "Spectral") +
   labs(x= 'cut quality',
        y= 'mean price', 
        title= "Cut Quality에 따른 가격 변화")

## (3) cut과 color에 따른 가격의 변화를 보여주는 그래프를 작성하세요.
m.price<- diamonds %>% 
   group_by(cut, color) %>%
   summarize(mean.price=mean(price))
m.price
ggplot(data= m.price, aes(x= cut, y= mean.price)) +
   geom_bar(stat = 'identity', aes(fill=color), position= 'dodge') +
   scale_fill_brewer(palette = "Spectral") +
   labs(x= 'cut quality',
        y= 'mean price', 
        title= "Cut Quality와 Color에 따른 가격 변화")