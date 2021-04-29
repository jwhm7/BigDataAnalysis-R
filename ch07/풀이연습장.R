# 연습문제 1. pg.237
x= c(10.0, 12.0, 9.5, 22.2, 8.0)
y= c(360.2, 420.0, 359.5, 679.0, 315.3)
model <- lm(y ~ x)
model
plot(x, y)
abline(model, col= 'red')
