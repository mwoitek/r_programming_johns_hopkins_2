# Example: Caching the Mean of a Vector.

# Function for making a new vector object:
make_vector <- function(x = numeric()) {

  # Initialize the mean of the vector:
  m <- NULL

  # Setter function for the vector:
  set <- function(y) {

    x <<- y

    # Reinitialize the mean:
    m <<- NULL

  }

  # Getter function for the vector:
  get <- function() x

  # Setter function for the mean of the vector:
  setmean <- function(mean) m <<- mean

  # Getter function for the mean of the vector:
  getmean <- function() m

  # Return the new vector object.
  # Return a list containing the methods associated with this object.
  list(
    set = set,
    get = get,
    setmean = setmean,
    getmean = getmean
  )

}

# Function for computing and/or retrieving the mean from the new vector object:
cachemean <- function(x, ...) {

  # Get the mean of the vector:
  m <- x$getmean()

  # If the mean isn't NULL, then just return it:
  if (!is.null(m)) {
    message("Getting cached mean")
    return(m)
  }

  # In this case, the mean is NULL.

  # Get the vector:
  data <- x$get()

  # Compute the mean:
  m <- mean(data, ...)

  # Cache the mean:
  x$setmean(m)

  # Return the mean:
  m

}
