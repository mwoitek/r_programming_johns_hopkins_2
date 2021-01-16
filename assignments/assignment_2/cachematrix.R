# Implementation of a matrix object that can cache its inverse matrix. This
# implementation consists of two functions. The first function is for making
# this new object, and the second one computes and/or retrieves from the object
# the corresponding inverse matrix.

# Function for creating a matrix object that can cache its inverse:
makeCacheMatrix <- function(X = matrix()) {

  # Initialize the inverse matrix:
  invX <- NULL

  # Setter for the matrix:
  set <- function(Y) {

    X <<- Y

    # Initialize the inverse matrix:
    invX <<- NULL

  }

  # Getter for the matrix:
  get <- function() X

  # Setter for the inverse matrix:
  setInverse <- function(inverse) invX <<- inverse

  # Getter for the inverse matrix:
  getInverse <- function() invX

  # Return the new matrix object.
  # Return a list containing the methods associated with this object.
  list(
    set = set,
    get = get,
    setInverse = setInverse,
    getInverse = getInverse
  )

}

# Function for computing and/or retrieving the inverse matrix:
cacheSolve <- function(X, ...) {

  # Get the inverse matrix:
  invX <- X$getInverse()

  # If the inverse matrix isn't NULL, then just return it:
  if (!is.null(invX)) {
    message("Getting cached inverse")
    return(invX)
  }

  # In this case, the inverse matrix is NULL.

  # Get the matrix:
  mat <- X$get()

  # Compute, cache and return the inverse matrix:
  invX <- solve(mat, ...)
  X$setInverse(invX)
  invX

}

# A few tests:

myMatrix <- makeCacheMatrix(cbind(c(-1, 1), c(1.5, -1)))
test <- cacheSolve(myMatrix)
cacheSolve(myMatrix)
myMatrix$get() %*% test

myMatrix <- makeCacheMatrix(cbind(c(2, 0), c(0, 5)))
test <- cacheSolve(myMatrix)
cacheSolve(myMatrix)
myMatrix$get() %*% test
