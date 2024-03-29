# 반복문
# 1. repeat
# (1) 10까지의 합
i <- 1
sum <- 0
repeat {
   if (i > 10) {
      break
   }
   sum <- sum + i
   i <- i + 1
}
print(sum)
# (2) 10!
i <- 1
sum <- 1
repeat {
   if (i > 10) {
      break
   }
   sum <- sum * i
   i <- i + 1
}
print(sum)

# while
# (1) 10까지의 합
i <- 1
sum <- 0
while (i <=10) {
   sum <- sum + i
   i <- i + 1
}
print(sum)
# (2) 10!
i <- 1
product <- 1
while (i <= 10) {
   product <- product * i
   i <- i + 1
}
print(product)

# for
# (1) 10까지의 합
sum <- 0
for (i in 1:10) {
   sum <- sum + i
}
print(sum)
# (2) 10!
product <- 1
for (i in 1:10) {
   product <- product * i
}
print(product)
# 1-100 홀수만 더하기
sum <- 0
for(i in 1:100) { 
   if(i %% 2 == 1)  # {}를 뺴먹었다.
   sum <- sum + i
}
print(sum)
# - 풀이
odd_sum <- 0
for(i in 1:100) {
   if(i %% 2 ==1) {
      odd_sum <- odd_sum + i
   }
}
print(odd_sum)
# 100점짜리 답
odd_sum <- 0
for (i in seq(1, 100, by=2)) {
   odd_sum <-odd_sum + i
}
print(odd_sum)

# 구구단 만들기
# 2단
for(k in 1:9) {
   print(paste('2', 'x', k, '*', 2*k))
}

for (i in 2:9) {
   print(paste0(i, '단========================='))
   for(k in 1:9) {
      print(paste(i, 'x', k, '*', i*k))
   }
}

# 문제
# 1) 숫자의 합
# 2) 숫자 제곱의 합
# 3) 첫행, 둘째행 제곱, 셋째행 세제곱의 합
x <- 1:12
x
dim(x) <- c(3:4)
x
sum(1:12)

pwr_sum <- 0
for (i in 1:12) {
   pwr_sum <- i^2
}
print(pwr_sum)

# Matrix 문제정답
mat <- matrix(1:12, nrow=3)
nrow <- 3
ncol <- 4

sum1 <- 0
sum2 <- 0
sum3 <- 0
for (i in 1:nrow) {
   for (k in 1:ncol) {
      sum1 <- sum1 + mat[i, k]
      sum2 <- sum2 + mat[i, k] **2
      sum3 <- sum3 + mat[i, k] **i
   }
}
print(paste(sum1, sum2, sum3))

# 별그리기
for (i in 1:5) {
   star <- ''
   for (k in 1:i) {
      star <- paste0(star, '+')
   }
   print(star)
}

# list 만들기
lst = list()
lst <- append(lst,3)
lst <- append(lst,5)
lst <- append(lst,7)
length(lst)
lst[1]
lst[2]
lst[3]

lst <- list()
for (i in 1:5) {
   lst <- append(lst, i)
}
lst

for(element in lst) {
   print(element)
}


# Enhanced-for-loop
vec <- c(1, 7, 8)
for (element in vec) {
   print(element)
}

for(element in mat) {
   print(element)
}

# 약수
N = 24
for (num in 1:N) {
   if (N %% num == 0) {
      print(num)
   }
}
# 약수의 합
sum <- 0
for (num in 1:N) {
   if (N %% num == 0) {
      sum <- sum + num
   }
}
print(sum)

# Perfect Number
# 2에서 10000 사이의 완전수를 찾으시오.
for (N in 2:10000) {
   sum <- 0
   for (num in 1:(N-1)) {
      if (N %% num == 0) {
         sum <- sum + num
      }
   }
   if(sum == N) {
      print(N)
   }
}
