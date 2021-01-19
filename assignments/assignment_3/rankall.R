## 3rd part

## Import the necessary libraries
library(dplyr)
library(magrittr)
library(purrr)
library(readr)
library(tidyr)

## Adapted version of `rankhospital`. This function receives the data after it
## has been read and filtered.
rankhospital_adapted <- function(dat, state, num) {

  ## Get only the data associated with the specified state
  dat_state <-
    dat %>%
      filter(state.abbr == state) %>%
      select(!c(state.abbr))

  ## Vector containing the names of the hospitals
  hospitals <- dat_state$hospital

  ## Compute the number of hospitals
  number_hospitals <- length(hospitals)

  ## Vector containing the 30-day death rates
  death_rates <- dat_state[[2]]

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

  ## Return hospital name with the given rank 30-day death rate
  idx <- (order(death_rates, hospitals))[rank]
  hospitals[idx]

}

## Function for ranking hospitals by outcome in all states
rankall <- function(outcome, num = "best") {

  ## Vector containing the valid outcomes
  outcomes <- c("heart attack", "heart failure", "pneumonia")

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
    drop_na()

  ## Vector containing the state abbreviations
  states <- c(
    "AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DC", "DE", "FL",
    "GA", "GU", "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA",
    "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC", "ND",
    "NE", "NH", "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA",
    "PR", "RI", "SC", "SD", "TN", "TX", "UT", "VA", "VI", "VT",
    "WA", "WI", "WV", "WY"
  )

  ## Find the desired hospital name for every state
  hospitals <- c()
  for (state in states) {
    hospitals <- c(hospitals, rankhospital_adapted(dat, state, num))
  }

  ## Create and return the data frame
  df <- data.frame(hospitals, states)
  colnames(df) <- c("hospital", "state")
  df

}
