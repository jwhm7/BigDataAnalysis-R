# UCLA 데이터에 대해서 Cross validation을 하고 
# 4가지 모델에 대해서 정확도, 정밀도, 재형율을 구하시오
library(caret)
library(rpart)
library(randomForest)
library(e1071)
library(class) 

set.seed(2021)
ucla <- read.csv('http://stats.idre.ucla.edu/stat/data/binary.csv')
ucla$admit <- factor(ucla$admit)
data <- ucla[sample(nrow(ucla)),]

# K-Fold CV, K=5
k <- 5
q <- nrow(data) / k
l <- 1:nrow(data)
accuracy <- 0
precision <- 0
recall <- 0

# Decision Tree
for(i in 1:k){
  test_list <- ((i-1)*q+1) : (i*q)
  data_test <- data[test_list, ]
  data_train <- data[-test_list, ]
  dt <- rpart(admit~., data_train)
  pred <- predict(dt, data_test, type= 'class')
  t <- table(pred, data_test$admit)
  accuracy <- accuracy + (t[1,1] + t[2,2]) / nrow(data_test)
  precision <- precision + t[2,2]/(t[2,1]+t[2,2])
  recall <- recall + t[2,2]/(t[1,2]+t[2,2])
}

dt_avg_accuracy <- accuracy / k
dt_avg_prec <- precision / k
dt_avg_recall <- recall / k
options(digits = 4)
sprintf('결정트리: 정확도= %f, 정밀도= %f, 재현률= %f',
        dt_avg_accuracy, dt_avg_prec, dt_avg_recall)

# Random Forest
k <- 5
q <- nrow(data) / k
l <- 1:nrow(data)
accuracy <- 0
precision <- 0
recall <- 0

for(i in 1:k){
  test_list <- ((i-1)*q+1) : (i*q)
  data_test <- data[test_list, ]
  data_train <- data[-test_list, ]
  rf <- randomForest(admit~., data_train)
  pred <- predict(rf, data_test, type= 'class')
  t <- table(pred, data_test$admit)
  accuracy <- accuracy + (t[1,1] + t[2,2]) / nrow(data_test)
  precision <- precision + t[2,2]/(t[2,1]+t[2,2])
  recall <- recall + t[2,2]/(t[1,2]+t[2,2])
}

rf_avg_accuracy <- accuracy / k
rf_avg_prec <- precision / k
rf_avg_recall <- recall / k
options(digits = 4)
sprintf('랜덤포레스트: 정확도= %f, 정밀도= %f, 재현률= %f',
        rf_avg_accuracy, rf_avg_prec, rf_avg_recall)

# SVM
k <- 5
q <- nrow(data) / k
l <- 1:nrow(data)
accuracy <- 0
precision <- 0
recall <- 0

for(i in 1:k){
  test_list <- ((i-1)*q+1) : (i*q)
  data_test <- data[test_list, ]
  data_train <- data[-test_list, ]
  sv <- svm(admit~., data_train)
  pred <- predict(sv, data_test, type= 'class')
  t <- table(pred, data_test$admit)
  accuracy <- accuracy + (t[1,1] + t[2,2]) / nrow(data_test)
  precision <- precision + t[2,2]/(t[2,1]+t[2,2])
  recall <- recall + t[2,2]/(t[1,2]+t[2,2])
}

sv_avg_accuracy <- accuracy / k
sv_avg_prec <- precision / k
sv_avg_recall <- recall / k
options(digits = 4)
sprintf('SVM: 정확도= %f, 정밀도= %f, 재현률= %f',
        sv_avg_accuracy, sv_avg_prec, sv_avg_recall)

# K-NN
k <- 5
q <- nrow(data) / k
l <- 1:nrow(data)
accuracy <- 0
precision <- 0
recall <- 0

for(i in 1:k){
  test_list <- ((i-1)*q+1) : (i*q)
  data_test <- data[test_list, ]
  data_train <- data[-test_list, ]
  pred <- knn(data_train[,2:4], data_test[,2:4],
              data_train$admit, k=5)
  t <- table(pred, data_test$admit)
  accuracy <- accuracy + (t[1,1] + t[2,2]) / nrow(data_test)
  precision <- precision + t[2,2]/(t[2,1]+t[2,2])
  recall <- recall + t[2,2]/(t[1,2]+t[2,2])
}

knn_avg_accuracy <- accuracy / k
knn_avg_prec <- precision / k
knn_avg_recall <- recall / k
options(digits = 4)
sprintf('K-NN: 정확도= %f, 정밀도= %f, 재현률= %f',
        knn_avg_accuracy, knn_avg_prec, knn_avg_recall)

############################################################################
# ucla
# 1) 4가지 모델 DT, RF, SV, K-NN
library(caret)
ucla <- read.csv('http://stats.idre.ucla.edu/stat/data/binary.csv')
head(ucla)
set.seed(2021)
data <- ucla[sample(nrow(ucla)),]
head(data)
ucla$admit <- factor(ucla$admit)
control <- trainControl(method='cv', number= 5)
dt <- train(admit~., data=ucla, method= 'rpart',
            metric= 'Accuracy', trControl= control)
rf <- train(admit~., data=ucla, method= 'rf',
            metric= 'Accuracy', trControl= control)
sv <- train(admit~., data=ucla, method= 'svmRadial',
            metric= 'Accuracy', trControl= control)
kn <- train(admit~., data=ucla, method= 'knn',
            metric= 'Accuracy', trControl= control)
resamp <- resamples(list(결정트리= dt, 랜덤포레스트= rf, SVM= sv, KNN= kn))
summary(resamp)
sort(resamp, decreasing= T)
dotplot(resamp)
# 2) CV= 5
# 3) 정확도, 정밀도, 재현률
confusionMatrix(dt)
# TP = 64.5, FP = 25.2, FN = 3.8, TN = 6.5
# 정확도
(64.5+25.2)/nrow(ucla)   # 0.22425
# 정밀도
(64.5)/(64.5+25.2)       # 0.7190635
# 재현률
(64.5)/(64.5+3.8)        # 0.9443631
# 풀이
table(pred, Y)
(t[1,1]+t[2,2])/nrow(ucla)
(t[2,2])/(t[2,1]+t[2,2])
(t[2,2])/(t[1,2]+t[2,2])
