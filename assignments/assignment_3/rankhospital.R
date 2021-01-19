## 2nd part

## Import the necessary libraries
library(dplyr)
library(magrittr)
library(purrr)
library(readr)
library(tidyr)

## Function for ranking hospitals by outcome in a state
rankhospital <- function(state, outcome, num = "best") {

  ## Vector containing the state abbreviations
  states <- c(
    "AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DC", "DE", "FL",
    "GA", "GU", "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA",
    "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC", "ND",
    "NE", "NH", "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA",
    "PR", "RI", "SC", "SD", "TN", "TX", "UT", "VA", "VI", "VT",
    "WA", "WI", "WV", "WY"
  )

  ## Vector containing the valid outcomes
  outcomes <- c("heart attack", "heart failure", "pneumonia")

  ## Check that state is valid
  if (!(state %in% states)) {
    stop("Invalid state")
  }

  ## Check that outcome is valid
  if (!(outcome %in% outcomes)) {
    stop("Invalid outcome")
  }

  ## Get the index of the outcome column
  outcome_column <-
    detect_index(
      outcomes,
      function(out) {
        out == outcome
      }
    ) + 2

  ## Read data
  dat <-
    read_csv(
      file = file.path(
        "rprog_data_ProgAssignment3-data",
        "outcome-of-care-measures.csv"
      ),
      col_types = "_c____c___d_____d_____d_______________________",
      na = c("", "Not Available")
    ) %>%
    rename(
      hospital = 1,
      state.abbr = 2,
      heart.attack = 3,
      heart.failure = 4,
      pneumonia = 5
    ) %>%
    select(c(1, 2, outcome_column)) %>%
    filter(state.abbr == state) %>%
    select(!c(state.abbr)) %>%
    drop_na()

  ## Vector containing the names of the hospitals
  hospitals <- dat$hospital

  ## Compute the number of hospitals
  number_hospitals <- length(hospitals)

  ## Deal with the `num` argument. I'm assuming this argument will be valid.
  if (is.numeric(num)) {
    if (num > number_hospitals) {
      return(NA)
    }
    rank <- num
  } else if (num == "best") {
    rank <- 1
  } else {
    rank <- number_hospitals
  }

  ## Vector containing the 30-day death rates
  death_rates <- dat[[2]]

  ## Return hospital name with the given rank 30-day death rate
  idx <- (order(death_rates, hospitals))[rank]
  hospitals[idx]

}
