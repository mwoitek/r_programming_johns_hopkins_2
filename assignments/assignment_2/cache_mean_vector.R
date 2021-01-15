# Example: Caching the Mean of a Vector.

# Function for creating a vector object that can cache its mean:
makeVector <- function(x = numeric()) {

  # Initialize the mean:
  m <- NULL

  # Setter for the vector:
  set <- function(y) {

    x <<- y

    # Initialize the mean:
    m <<- NULL

  }

  # Getter for the vector:
  get <- function() x

  # Setter for the mean:
  setMean <- function(mean) m <<- mean

  # Getter for the mean:
  getMean <- function() m

  # Return the new vector object.
  # Return a list containing the methods associated with this object.
  list(
    set = set,
    get = get,
    setMean = setMean,
    getMean = getMean
  )

}

# Function for computing and/or retrieving the mean:
cacheMean <- function(x, ...) {

  # Get the mean:
  m <- x$getMean()

  # If the mean isn't NULL, then just return it:
  if (!is.null(m)) {
    message("Getting cached mean")
    return(m)
  }

  # In this case, the mean is NULL.

  # Get the vector:
  vec <- x$get()

  # Compute, cache and return the mean:
  m <- mean(vec, ...)
  x$setMean(m)
  m

}

# A few tests:

myVec <- makeVector(c(1:5))
test <- cacheMean(myVec)
cacheMean(myVec)

myVec <- makeVector(seq(from = 3, to = 15, by = 3))
test <- cacheMean(myVec)
cacheMean(myVec)
