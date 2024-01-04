getwd
setwd('/workspace/R')


# 변수(Variable)
x <- 1
y <- 2
z <- x + y
z

# Swapping
temp <- x
x <- y
y <- temp

# 변수의 타입(Variable Type)
typeof(x)
a <- 'string'
typeof(a)
b <- "double quote"
typeof(b)
c <- '한글'

# 실수(Numeric)
x <- 5
y <- 2
x / y

# 복소수(Complex)
xi <- 1 + 2i
yi <- 1 - 2i
xi + yi
xi * yi

# 범주형(Category)
blood_type = factor(c('A', 'B', 'O', 'AB'))
blood_type

#  논리형(Boolean)
TRUE
FALSE
T
F


xinf = Inf
yinf = -Inf
xinf / yinf

# 데이터형 확인 함수(Datatype Verification Function)
class(x)  # R 객체지향 관점(Object Oriented Perspective)
typeof(x) # R 언어자체 관점(Language Oriented Perspective)
is.integer(x)
is.numeric(x)
is.complex(xi)
is.character(c)
is.na(xinf/yinf)

# 데이터형 변환 함수(Datatype Transformation Function)
is.integer(as.integer(x))
is.factor(as.factor(c))

# 연산자(Operator)
5^2
4^(1/2)
x %% y    # 나머지(Modulo)  # n의 배수인 수 설정 시 자주 사용(Frequently used to set multiples of n)
x %/% y   # 몫
y <- 2

# 비교 연산자(Comparison Operator)
x < y
x <= y
x >= y
x == y
x != y

# 논리 연산자(!, |, &)(Logical Operator)
!T
!F
x | y  # OR
x & y  # AND
x || y
a <- c(F, F, T, T)
b <- c(F, T, F, T)
a | b    # element-wise OR
a || b   # 첫번째 엘리먼트의 논리합(Logical sum of the first element)
a & b
a && b
2^-3-5**(1/2)>2  # 2^-3 - 5**(1/2) > 2로 쓸 것
