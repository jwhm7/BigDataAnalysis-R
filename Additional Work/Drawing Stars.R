# 오른쪽 위 직각삼각형 (4)
for (i in 1:4) {
  star <- ' '
  for (k in 1:i) {
    star <- paste0(star, '+')
  }
  print(star, quote = FALSE)    # 특수 문자에서 따옴표 제거하기: print(m, quote = FALSE)
}

# 왼쪽 위 직각삼각형 (5)
for (i in 1:5){
  star <- ' '
  for (k in 1:(5-i)){
    if ((5-i)>0) star <- paste0(star, ' ')
  }
  for(k in 1:i){
    star <- paste0(star, '+')
  }
  print(star, quote = FALSE)
}

# 오른쪽 아래 직각삼각형 (3)
for (i in 1:3) {
  star <- ' '
  for (k in 0:(3-i)) {
    star <- paste0(star, '+')
  }
  print(star, quote = FALSE)
}

# 왼쪽 아래 직각삼각형 (4)
for (i in 1:4) {
  star <- ' '
  for (k in 1:i) {
    if (k < i) star <- paste0(star, ' ')
  }
  for (k in 1:(5-i)) {
    if (k <= (5-i)) star <- paste0(star, '+')
  }
    print(star, quote=FALSE)
}
}
