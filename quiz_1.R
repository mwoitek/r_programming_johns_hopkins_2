# This file contains the code I used to obtain the answers to the questions in
# the 1st quiz.

# Question 4
x <- 4
class(x)
# Answer: numeric

# Question 5
x <- c(4, TRUE)
class(x)
# Answer: numeric

# Question 6
x <- c(1, 3, 5)
y <- c(3, 2, 10)
rbind(x, y)
# Answer: a matrix with two rows and three columns

# Question 8
x <- list(2, "a", "b", TRUE)
y <- x[[1]]
y
class(y)
is.vector(y)
# Answers: a numeric vector containing the element 2; a numeric vector of
# length 1

# Question 9
x <- 1:4
y <- 2
z <- x + y
z
class(z)
# Answer: a numeric vector with elements 3, 4, 5, 6

# Question 12
data <- read.csv("hw1_data.csv", header = TRUE)
head(data, n = 2L)

# Question 13
nrow(data)
# Answer: 153

# Question 14
tail(data, n = 2L)

# Question 15
ozone <- data["Ozone"]
ozone[47, ]
# Answer: 21

# Question 16
length(ozone[is.na(ozone) == TRUE])
# Answer: 37

# Question 17
mean(ozone[is.na(ozone) == FALSE])
# Answer: 42.12931

# Question 18
cond <- which(data["Ozone"] > 31 & data["Temp"] > 90)
subs <- data[cond, ]
mean(subs[["Solar.R"]])
# Answer: 212.8

# Question 19
cond <- which(data["Month"] == 6)
subs <- data[cond, ]
mean(subs[["Temp"]])
# Answer: 79.1

# Question 20
cond <- which(data["Month"] == 5)
subs <- data[cond, ]
max(subs[["Ozone"]], na.rm = TRUE)
# Answer: 115
