# Support Vector Machine(SVM)
library(caret)
library(e1071)

set.seed(2021)
train_index <- createDataPartition(iris$Species, p= 0.8, list= F)
iris_train <- iris[train_index, ]
iris_test <- iris[-train_index, ]

# 모델링
svc <- svm(Species~., iris_train)

# 예측
pred <- predict(svc, iris_test, type= 'class')

# 평가
table(pred, iris_test$Species)
confusionMatrix(pred, iris_test$Species)

# Hyper Parameter
svc100 <- svm(Species~., iris_train, cost= 100)   # c = 100 촘촘한그래프
pred100 <- predict(svc100, iris_test, type= 'class')
table(pred100, iris_test$Species)

svc001 <- svm(Species~., iris_train, cost= 0.01)    # c= 0.01 널널한그래프
pred001 <- predict(svc001, iris_test, type= 'class')
table(pred001, iris_test$Species)

# 모델을 훈련했을 때의 데이터로 예측
self100 <- predict(svc100, iris_train, type= 'class')
table(self100, iris_train$Species)

self001 <- predict(svc001, iris_train, type= 'class')
table(self001, iris_train$Species)

# K-NN (Nearest Neighbor) - K-최근접 이웃
library(class)
k <- knn(iris_train[, 1:4], iris_test[, 1:4], 
         iris_train$Species, k= 5 )
k
iris_test$Species
confusionMatrix(k, iris_test$Species)

# train 함수
dt <- train(Species~., data= iris_train, method= 'rpart')
rf <- train(Species~., data= iris_train, method= 'rf')
sv <- train(Species~., data= iris_train, method= 'svmRadial')
kn <- train(Species~., data= iris_train, method= 'knn')
names(getModelInfo())
