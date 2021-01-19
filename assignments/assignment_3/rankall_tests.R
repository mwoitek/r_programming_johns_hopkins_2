## A few tests to see if the `rankall` function works as intended

source("rankall.R")

## Test case 1
head(rankall("heart attack", 20), 10)

## Test case 2
tail(rankall("pneumonia", "worst"), 3)

## Test case 3
tail(rankall("heart failure"), 10)
