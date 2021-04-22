# 데이터 프레임
name <- c('철수', '춘향', '길동')
age <- c(22, 20, 25)
gender <- factor(c('M', 'F', 'M'))
blood_type <- factor(c('A', 'O', 'B'))

patients <- data.frame(name, age, gender, blood_type)
patients

patients$name
typeof(patients$name)
patients[1,]  # 첫번째 행의 전부 다(비어 있는 부분 = all) (->not that preferred way)
patients[,2]  # patients$age와 동일
patients[2,3]  # F
patients$gender[3]  # M(->preferred way) 
patients[patients$name == '철수',]   # patients[1,]와 동일한 방법 -> filtering이라고 부름
patients[patients$name == '철수', c('age', 'gender')]  # -> selection and filtering

# 데이터프레임의 속성명을 변수명으로 사용(attach)
attach(patients)  # 이 이후부터 patients$ 생략하고 사용 가능
name
blood_type
detach(patients)  # 여기부터 detach 됨

head(cars)
attach(cars)
speed
dist
detach(cars)
speed   # 에러: 객체 'speed'를 찾을 수 없습니다

mean(cars$speed)
max(cars$dist)
with(cars, mean(speed))

# subst
subset(cars, speed>20)  # -> 별로 사용 안됨
cars[cars$speed>20,]  # -> 이 방법을 더 많이 사용함
subset(cars, speed>20, select = c(dist))
subset(cars, speed>20, select = -c(dist))

# 결측값(NA) 처리
head(airquality)
str(airquality)
sum(airquality$Ozone)  # 중간에 결측값이 있으면 전체가 결측값이됨

head(na.omit(airquality))   # 결측값이 제거된 상태. NA있는 행 전체를 제거

# 병합(merge)
patients
patients1 <- data.frame(name, age, gender)
patients2 <- data.frame(name, blood_type)
merge(patients1, patients2, by='name')

# 데이터프레임에 행 추가
length(patients1$name)
patients1[length(patients1$name)+1, ] <- c('몽룡', 19, 'M')
patients1
length(patients2$blood_type)
patients2[length(patients2$blood_type)+1, ] <- c('영희', 'A' )
patients2

# 열 추가
patients1['birth_year'] <- c(1500,1550,1600,1800)
patients1

# merge
# Inner join
merge(patients1, patients2)  # x, y
# Left outer join
merge(patients1, patients2, all.x=T)
# Right outer join
merge(patients1, patients2, all.y=T)
# (Full) outer join
merge(patients1, patients2, all.x=T, all.y=T)
