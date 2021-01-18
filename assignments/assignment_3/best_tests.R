## A few tests to see if the `best` function works as intended

source("best.R")

## Test case 1
best("TX", "heart attack")

## Test case 2
best("TX", "heart failure")

## Test case 3
best("MD", "heart attack")

## Test case 4
best("MD", "pneumonia")

## Test case 5
best("BB", "heart attack")

## Test case 6
best("NY", "hert attack")
