pollutantmean <- function(directory, pollutant, id = 1:332) {
    # "directory" is a character vector of length 1. It stores the location of
    # the csv files.

    # "pollutant" is a character vector of length 1. It stores the name of the
    # pollutant ("sulfate" or "nitrate") for which we will calculate the mean.

    # "id" is an integer vector. It stores the monitor ID numbers to be used.

    # This function returns the mean of the pollutant across all monitors whose
    # IDs are in "id". NA values are ignored.

    num_monitors <- length(id)
    pollutant_num_rows <- vector(mode = "integer", length = num_monitors)
    pollutant_sums <- vector(mode = "numeric", length = num_monitors)

    idx <- 1
    for (monitor in id) {
        file_name <- paste(sprintf("%.3d", monitor), "csv", sep = ".")
        dat1mon <- read.csv(file.path(directory, file_name))
        pollutant_values <- dat1mon[[pollutant]]
        pollutant_values <- pollutant_values[!is.na(pollutant_values)]
        pollutant_num_rows[[idx]] <- length(pollutant_values)
        pollutant_sums[[idx]] <- sum(pollutant_values)
        idx <- idx + 1
    }

    sum(pollutant_sums) / sum(pollutant_num_rows)

}
