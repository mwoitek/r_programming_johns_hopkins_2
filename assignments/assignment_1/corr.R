corr <- function(directory, threshold = 0) {
    # "directory" is a character vector of length 1. It stores the location of
    # the csv files.

    # "threshold" is a numeric vector of length 1. It stores the number of
    # complete observations required to compute the correlation between nitrate
    # and sulfate measurements. The default value of "threshold" is 0.

    # This function returns a numeric vector containing the correlations.

    corrs <- vector(mode = "numeric", length = 0)

    for (monitor in 1:332) {
        file_name <- paste(sprintf("%.3d", monitor), "csv", sep = ".")
        dat1mon <- read.csv(file.path(directory, file_name))
        cobs <- dat1mon[complete.cases(dat1mon), ]
        if (nrow(cobs) >= threshold) {
            correlation <- cor(cobs["nitrate"], cobs["sulfate"])
            corrs <- c(corrs, correlation)
        }
    }

    corrs

}
