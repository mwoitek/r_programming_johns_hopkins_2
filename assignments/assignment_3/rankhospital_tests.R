## A few tests to see if the `rankhospital` function works as intended

source("rankhospital.R")

## Test case 1
rankhospital("TX", "heart failure", 4)

## Test case 2
rankhospital("MD", "heart attack", "worst")

## Test case 3
rankhospital("MN", "heart attack", 5000)
