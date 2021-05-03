# 분류 (Classification)
# 결정 트리(Decision Tree)
library(rpart)

head(iris)
dtc <- rpart(Species~., data = iris)   # iris 데이터를 결정트리로 그리기
summary(dtc)
dtc
# 결정 트리 시각화
par(mfrow=c(1,1), xpd=NA)   # 글자 다 보이게 함 
plot(dtc)
text(dtc, use.n=T)    # 글자 쓰는 함수

# 예측
pred <- predict(dtc, iris, type= 'class')
table(pred, iris$Species)

# 평가
library(caret)
confusionMatrix(pred, iris$Species)
# Accuracy 확인 가능 : 0.96

# 시각화
library(rpart.plot)
rpart.plot(dtc)
rpart.plot(dtc, type= 4)    # 계산식의 위치 옵션

# 훈련/테스트 셋으로 분리하여 시행
set.seed(2021)    # seed number를 부여, 실행 전 돌리고 식 돌리면 샘플 같은거 나와서 그래프 유지
sample(1:10, 4)
iris_index <- sample(1:nrow(iris), 0.8*nrow(iris))
iris_train <- iris[iris_index, ]
iris_test <- iris[setdiff(1:nrow(iris), iris_index), ]
# 같은 결과 나오는 식
iris_test <- iris[-iris_index, ]
dim(iris_train)
dim(iris_test)
table(iris_train$Species)

# 모델링
dtc <- rpart(Species~., iris_train)

# 예측
pred <- predict(dtc, iris_test, type = 'class')

# 평가
confusionMatrix(pred, iris_test$Species)
# Accuracy = 0.9

# 비율대로 훈련/테스트 데이터셋 만들기
train_index <- createDataPartition(iris$Species, p= 0.8, list=F)
iris_train <- iris[train_index, ]
iris_test <- iris[-train_index, ]
table(iris_train$Species)
table(iris_test$Species)

# 학습
dtc <- rpart(Species~., iris_train)

# 예측
pred <- predict(dtc, iris_test, type = 'class')

# 평가
confusionMatrix(pred, iris_test$Species)
# Accuracy가 그때그때 다름.

# 시각화  -> decision tree밖에 시각화 안됨.
rpart.plot(dtc)
