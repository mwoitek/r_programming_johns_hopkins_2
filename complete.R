complete <- function(directory, id = 1:332) {
    # "directory" is a character vector of length 1. It stores the location of
    # the csv files.

    # "id" is an integer vector. It stores the monitor ID numbers to be used.

    # This function returns a data frame of the form
    # id nobs
    # 1 117
    # 2 1041
    # ...
    # where "id" is the monitor ID number and "nobs" is the number of complete
    # cases.

    idx <- 1
    nobs <- vector(mode = "integer", length = length(id))

    for (monitor in id) {
        file_name <- paste(sprintf("%.3d", monitor), "csv", sep = ".")
        dat1mon <- read.csv(file.path(directory, file_name))
        nobs[[idx]] <- nrow(dat1mon[complete.cases(dat1mon), ])
        idx <- idx + 1
    }

    df <- data.frame(id, nobs)
    df

}
