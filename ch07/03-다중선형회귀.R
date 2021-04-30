# 영희의 물리 실험
library(scatterplot3d)

x <- c(3, 6, 3, 6.)
u <- c(10, 10, 20, 20.)
y <- c(4.65, 5.9, 6.7, 8.02)
scatterplot3d(x, u, y, 
               xlim= 2:7, ylim= 7:23, zlim= 0:10, 
              pch=20, type= 'h')

model <- lm(y ~ x + u)    # 독립변수로 x와 u를 쓰겠다. y= f(x, u)
coef(model)   # y= 0.428 * x + 0.209 * u + 1.26
s <- scatterplot3d(x, u, y, 
                  xlim= 2:7, ylim= 7:23, zlim= 0:10, 
                  pch=20, type= 'h')
s$plane3d(model)

# 오차 분석(잔차)
fitted(model)
y
residuals(model)    # y - fitted(model) = 잔차

# 평균 제곱 오차(MSE)
mse = deviance(model)/ length(y)
mse

# 새로운 데이터에 대한 예측
nx= c(7.5, 5)
nu= c(15, 12.)
new_data= data.frame(x= nx, u= nu)
ny <- predict(model, new_data)
ny
s <- scatterplot3d(nx, nu, ny, 
                   xlim= 0:10, ylim= 7:23, zlim= 0:10, 
                   pch=20, type= 'h', color = 'red', angle=60)
s$plane3d(model)

summary(model)

# tree 데이터
head(trees)
dim(trees)
summary(trees)
scatterplot3d(trees$Girth, trees$Height, trees$Volume)

# 모델링
tm <- lm(Volume ~ Girth + Height, data= trees)
tm
summary(tm)
# 높이는 0.05보다 작긴한데 별이 하나인걸보니 긴가민가. 다른 것들은 괜찮음.
# R-squared가 0.94인걸 보아하니 비교적 이 모델은 괜찮은 모델이다.

# 예측
ndata <- data.frame(Girth= c(8.5, 13, 19), Height= c(72, 86, 85.))
predict(tm, ndata)

# 다중회귀분석
?state.x77
state.x77
head(state.x77)
states <- as.data.frame(state.x77[, c("Murder", "Population", "Illiteracy", "Income", "Frost")])

fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data= states)
summary(fit)
par(mfrow= c(2,2))
plot(fit)
par(mfrow= c(1,1))

# 다중공선성: 독립변수간 강한 상관관계가 나타나는 문제
# Correleation (0.9 이상이면 다중공선성 의심)
states.cor <- cor(states[2:5])
states.cor
# There is nothing typical.

# VIF(Variation Inflation Factor) 계산 (10 이상이면 다중공선성 의심)
library(car)
vif(fit)

# Condition Number (15 이상이면 다중공선성의 가능성이 있음)
eigen.val <- eigen(states.cor)$values
sqrt(max(eigen.val)/eigen.val)
# PCA 차원축소 할때 사용.

fit1 <- lm(Murder ~ ., data= states)   # . : 변수를 다 집어넣음
summary(fit1)

fit2 <- lm(Murder ~ Population+ Illiteracy, data= states)   # 별 3개만 지정
summary(fit2)

# AIC(Akaike Information Criterion)
AIC(fit1, fit2)
# 값이 작을수록 좋은 모델

# Backward stepwise regression (변수를 하나씩 줄여가면서 무의미한 변수를
# 배제하면서 학습. p-value큰 것 부터) -> AIC
# = Backward Elimination
# Forward stepwise regression (변수를 하나씩 추가하면서 학습.)
# = Forward Selection
step(fit1, direction = 'backward')

fit3 <- lm(Murder ~ 1, data= states)
step(fit3, direction = 'forward', 
     scope = ~ Population + Illiteracy + Income +Frost)
step(fit3, direction= 'forward', scope= list(upper= fit1, lower= fit3))

library(leaps)
subsets <- regsubsets(Murder~., data= states,
                      method= 'seqrep', nbest=4)
subsets <- regsubsets(Murder~., data= states,
                      method = 'exhaustive', nbest= 4)
summary(subsets)
plot(subsets)

# 보스톤 주택가격 참고하기.