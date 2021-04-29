# 현실 세계의 모델링
X= c(3, 6, 9, 12.)    # 숫자 뒤에 점을 찍으면 실수
Y= c(3, 4, 5.5, 6.5)
plot(X, Y)

# model 1: y=0.5x+1.0
Y1= 0.5*X + 1.0
Y1
# 평균 제곱 오차: Mean Squared Error(MSE) -> equation written in my note.
(Y - Y1)**2
sum((Y - Y1)**2)
mse <- sum((Y - Y1)**2) / length(Y)
mse

# model 2: y=5/12x +7/4
Y2= 5*X/12+7/4
Y2
mse2 <- sum((Y - Y2)**2) / length(Y)
mse2
# 두번째 모델이 더 좋다

# R의 단순 선형회귀 모델 lm
model <- lm(Y ~ X)
model

plot(X, Y)
abline(model, col='red')
fitted(model)
mse_model <- sum((Y - fitted(model))**2) / length(Y)
mse_model

# 잔차- Residuals 
# 예측한 선하고 동그라미의 차이. 각각의 자료가 직선에 얼마나 잘 맞는지 확인하는도구.
# 굉장히 중요(나중에 선형회귀 할 때 잔차분석을 함)
residuals(model)

# 잔차 제곱합
# -> sum((Y - fitted(model))**2)
deviance(model)

# 평균 제곱 오차(MSE)
deviance(model) /length(Y)

summary(model)
# Adjusted R-squared 값은 0~1. 1에 가까울수록 모델이 현상을 잘 설명. 쓸만 한 모델이다.

# 예측
newX <-data.frame(X=c(1.2, 2.0, 20.65))
newY <- predict(model, newdata=newX)
newY
