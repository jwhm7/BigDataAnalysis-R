# 일반화 선형 모델
# 로지스틱 회귀 - UCLA admission data
ucla <- read.csv('http://stats.idre.ucla.edu/stat/data/binary.csv')
str(ucla)

lr <- glm(admit ~ ., data= ucla, family = binomial)
coef(lr)

test <- data.frame(gre= c(376), gpa= c(3.6), rank= c(3))
predict(lr, newdata= test, type = 'response')   # 실제로는 불합격이라는 얘기

# ucla 데이터 셋 train/test data set으로 분할
train_index <- sample(1:nrow(ucla), 0.8*nrow(ucla))     # 80%를 훈련셋, 20%을 테스트셋으로
test_index <- setdiff(1:nrow(ucla), train_index)        # 차집합을 테스트셋으로 지정
ucla_train <- ucla[train_index,]
ucla_test <- ucla[test_index,]
dim(ucla_train)
dim(ucla_test)

# 분할 비율은 적절한가?
table(ucla$admit)   # 127/400 -> 0.3175
table(ucla_train$admit)   # 101/320 -> 0.3156
# 어느정도 적절함.

# 훈련 데이터셋으로 학습, 테스트 데이터셋으로 예측
lr <- glm(admit~., ucla_train, family= binomial)
pred <- predict(lr, ucla_test, type= 'response')
pred   # 여기에 이제 판별식을 하나 더 주면 
ucla_test$admit
# 얘와 비교해서 0에 0, 1에 1 맞친개수가 정확도임. 그걸로 평가를 하는 것.