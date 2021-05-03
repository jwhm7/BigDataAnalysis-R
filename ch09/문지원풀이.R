# 1. UCLA 4가지 모델, 모델링, 예측, 평가

# (1) decision tree
library(rpart)
ucla <- read.csv('http://stats.idre.ucla.edu/stat/data/binary.csv')
ucla$admit= factor(ucla$admit)
str(ucla)
head(ucla)

set.seed(2021)
ucla_index <- createDataPartition(ucla$admit, p= 0.8, list=F)
ucla_train <- ucla[ucla_index, ]
ucla_test <- ucla[-ucla_index, ]

dim(ucla_train)
dim(ucla_test)
table(ucla_train$admit)
# 모델링
dtc <- rpart(admit~., data = ucla_train)
# 예측
pred <- predict(dtc, ucla_test, type = 'class')
# 평가
confusionMatrix(pred, ucla_test$admit)
# Accuracy = 0.6203
# 정확도 68.35%으로 정확하다고 하기 어렵다.

# (2) Random Forest
set.seed(2021)
ucla_index <- createDataPartition(ucla$admit, p= 0.8, list=F)
ucla_train <- ucla[ucla_index, ]
ucla_test <- ucla[-ucla_index, ]

# 모델링
rf <- randomForest(admit~., ucla_train,
                   ntree= 100, nodesize= 4)
rf

# 예측
pred <- predict(rf, ucla_test, type= 'class')

# 평가
confusionMatrix(pred, ucla_test$admit)
# Accuracy = 0.7342
# 정확도 73.42%로 decision tree와 비교했을 때 상대적으로 정확도가 높지만, 자체로는 정확도가 높다고 하기 어렵다.

# 시각화
plot(rf)

# (3) SVM
library(caret)
library(e1071)

set.seed(2021)
ucla_index <- createDataPartition(ucla$admit, p= 0.8, list=F)
ucla_train <- ucla[ucla_index, ]
ucla_test <- ucla[-ucla_index, ]

# 모델링
svc <- svm(admit~., ucla_train)

# 예측
pred <- predict(svc, ucla_test, type= 'class')

# 평가
table(pred, ucla_test$admit)
confusionMatrix(pred, ucla_test$admit)
# Accuracy = 0.7342

# Hyper Parameter
svc100 <- svm(admit~., ucla_train, cost= 100)
pred100 <- predict(svc100, ucla_test, type= 'class')
table(pred100, ucla_test$admit)
confusionMatrix(pred100, ucla_test$admit)
# 0.6962

svc50 <- svm(admit~., ucla_train, cost= 50)
pred50 <- predict(svc50, ucla_test, type= 'class')
table(pred50, ucla_test$admit)
confusionMatrix(pred50, ucla_test$admit)
# 0.7089

svc40 <- svm(admit~., ucla_train, cost= 40)
pred40 <- predict(svc40, ucla_test, type= 'class')
table(pred40, ucla_test$admit)
confusionMatrix(pred40, ucla_test$admit)
# 0.7342

# (4) K-NN
library(class)
k <- knn(ucla_train[, 1:4], ucla_test[, 1:4], 
         ucla_train$admit, k= 5 )
k
ucla_test$admit
confusionMatrix(k, ucla_test$admit)
# Accuracy = 0.9114

k <- knn(ucla_train[, 1:4], ucla_test[, 1:4], 
         ucla_train$admit, k= 3 )
k
ucla_test$admit
confusionMatrix(k, ucla_test$admit)
# Accuracy = 0.9367

k <- knn(ucla_train[, 1:4], ucla_test[, 1:4], 
         ucla_train$admit, k= 7 )
k
ucla_test$admit
confusionMatrix(k, ucla_test$admit)
# Accuracy = 0.8608

# 1. wine 4가지 모델, 모델링, 예측, 평가

# (1) decision tree
library(rpart)
wine_d <- read.table('data/wine_Data.txt', sep = ',')
wine_n <- readLines('data/wine_name.txt')
head(wine)
names(wine) <- wine_n
head(wine)

wine$name= factor(wine$name)

set.seed(2021)
wine_index <- createDataPartition(wine$`name 1`, p= 0.8, list=F)
wine_train <- wine[wine_index, ]
wine_test <- wine[-wine_index, ]

dim(wine_train)
dim(wine_test)
table(ucla_train$admit)

# 모델링
dtc <- rpart('name 1'~., data = wine_train)

# 예측
pred <- predict(dtc, ucla_test, type = 'class')

# 평가
confusionMatrix(pred, ucla_test$admit)
# Accuracy = 0.6203
# 정확도 68.35%으로 정확하다고 하기 어렵다.

# (2) Random Forest
set.seed(2021)
ucla_index <- createDataPartition(ucla$admit, p= 0.8, list=F)
ucla_train <- ucla[ucla_index, ]
ucla_test <- ucla[-ucla_index, ]

# 모델링
rf <- randomForest(admit~., ucla_train,
                   ntree= 100, nodesize= 4)
rf

# 예측
pred <- predict(rf, ucla_test, type= 'class')

# 평가
confusionMatrix(pred, ucla_test$admit)
# Accuracy = 0.7342
# 정확도 73.42%로 decision tree와 비교했을 때 상대적으로 정확도가 높지만, 자체로는 정확도가 높다고 하기 어렵다.

# 시각화
plot(rf)

# (3) SVM
library(caret)
library(e1071)

set.seed(2021)
ucla_index <- createDataPartition(ucla$admit, p= 0.8, list=F)
ucla_train <- ucla[ucla_index, ]
ucla_test <- ucla[-ucla_index, ]

# 모델링
svc <- svm(admit~., ucla_train)

# 예측
pred <- predict(svc, ucla_test, type= 'class')

# 평가
table(pred, ucla_test$admit)
confusionMatrix(pred, ucla_test$admit)
# Accuracy = 0.7342

# Hyper Parameter
svc100 <- svm(admit~., ucla_train, cost= 100)
pred100 <- predict(svc100, ucla_test, type= 'class')
table(pred100, ucla_test$admit)
confusionMatrix(pred100, ucla_test$admit)
# 0.6962

svc50 <- svm(admit~., ucla_train, cost= 50)
pred50 <- predict(svc50, ucla_test, type= 'class')
table(pred50, ucla_test$admit)
confusionMatrix(pred50, ucla_test$admit)
# 0.7089

svc40 <- svm(admit~., ucla_train, cost= 40)
pred40 <- predict(svc40, ucla_test, type= 'class')
table(pred40, ucla_test$admit)
confusionMatrix(pred40, ucla_test$admit)
# 0.7342

# (4) K-NN
library(class)
k <- knn(ucla_train[, 1:4], ucla_test[, 1:4], 
         ucla_train$admit, k= 5 )
k
ucla_test$admit
confusionMatrix(k, ucla_test$admit)
# Accuracy = 0.9114

k <- knn(ucla_train[, 1:4], ucla_test[, 1:4], 
         ucla_train$admit, k= 3 )
k
ucla_test$admit
confusionMatrix(k, ucla_test$admit)
# Accuracy = 0.9367

k <- knn(ucla_train[, 1:4], ucla_test[, 1:4], 
         ucla_train$admit, k= 7 )
k
ucla_test$admit
confusionMatrix(k, ucla_test$admit)
# Accuracy = 0.8608