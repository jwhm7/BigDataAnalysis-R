# 파일 읽기
getwd()
students <- read.table('data/students1.txt', header = T)  # 파일 이름을 data로 고쳐줘야 읽힘
students
str(students)

# read.csv는 첫 행을 헤더로 읽는 것이 디폴트
students <- read.csv('data/students.csv')
students

# 파일 쓰기 -> Encoding 신경쓸 것
write.table(students, file = 'data/output.txt', fileEncoding = 'utf-8')
write.csv(students, file='data/output.csv', fileEncoding = 'utf-8')

# row.names=F option 설정, 행 인덱스 번호를 저장하지 않음 -> 해당 행을 지우겠다
write.table(students, file = 'data/output.txt', fileEncoding = 'utf-8', row.names = F)
write.csv(students, file='data/output.csv', fileEncoding = 'utf-8', row.names = F)

# quote=F option -> quotation mark 지우기
write.table(students, file = 'data/output.txt', fileEncoding = 'utf-8', row.names = F, quote=F)
write.csv(students, file='data/output.csv', fileEncoding = 'utf-8', row.names = F, quote = F)

# 제대로 읽는지 확인
students <- read.table('data/output.txt', header = T, fill=T, fileEncoding = 'utf-8')
students
students <- read.csv('data/output.csv', header = T, fileEncoding = 'utf-8')
students
str(students)

# 읽을 때 stringAsFactors=F로 하면 문자열을 범주형으로 읽지 않음
students <- read.csv('data/output.csv', header = T, fileEncoding = 'utf-8', stringsAsFactors = F)
students
