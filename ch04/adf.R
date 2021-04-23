mul_sum <- function(n,x) {
   sum <- 0
   for (i in 1:n) {
      if (i %% x == 0)
      return(sum <- sum+i)
   }
}
mul_sum(6,2)


mul_sum <- function(n,x) {
   sum <- 0
   for (i in 1:n) {
      if (i %% x == 0) {
      sum <- sum+i
      }
      return(sum)
   }
}
mul_sum(6,2)

range_sum <- function(a,b) {
   sum <- 0
   for (i in a:b) {
      sum <- sum + i
   }
   return(sum)
}