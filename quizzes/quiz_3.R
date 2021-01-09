# ---
# jupyter:
#   jupytext:
#     formats: ipynb,R:percent,Rmd
#     text_representation:
#       extension: .R
#       format_name: percent
#       format_version: '1.3'
#       jupytext_version: 1.8.1
#   kernelspec:
#     display_name: R
#     language: R
#     name: ir
# ---

# %% [markdown]
# # R Programming: Quiz 3
#
# ## Imports

# %%
suppressPackageStartupMessages(library(datasets))
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(R.utils))

# %% [markdown]
# ## `iris` Dataset

# %%
data(iris)
head(iris)

# %% [markdown]
# ## Question 1

# %%
# Solution using base R:
iris_virginica <- iris[iris[["Species"]] == "virginica", 1:4]
mean_sepal_length <- apply(iris_virginica, 2, mean)[["Sepal.Length"]]
R.utils::printf("Mean of Sepal.Length = %.3f\n", mean_sepal_length)
R.utils::printf("Rounded Mean of Sepal.Length = %d", round(mean_sepal_length))

# %%
# Solution using the `tidyverse` library:
iris_virginica <- iris %>%
    dplyr::filter(Species == "virginica") %>%
    dplyr::select(!c(Species))
mean_sepal_length <- dplyr::summarise(
    iris_virginica,
    mean = mean(Sepal.Length)
)[[1, 1]]
R.utils::printf("Mean of Sepal.Length = %.3f\n", mean_sepal_length)
R.utils::printf("Rounded Mean of Sepal.Length = %d", round(mean_sepal_length))

# %% [markdown]
# ## Question 2

# %%
# Correct answer:
apply(iris[, 1:4], 2, mean)

# %%
# Get the same result using the `tidyverse` library:
iris %>%
    dplyr::select(!c(Species)) %>%
    dplyr::summarise(
        Sepal.Length = mean(Sepal.Length),
        Sepal.Width = mean(Sepal.Width),
        Petal.Length = mean(Petal.Length),
        Petal.Width = mean(Petal.Width)
    )

# %% [markdown]
# ## `mtcars` Dataset

# %%
data(mtcars)
head(mtcars)

# %% [markdown]
# ## Question 3

# %%
# Solution using the `tapply` function:
tapply(mtcars$mpg, mtcars$cyl, mean)

# %%
# Solution using the `with` and `tapply` functions:
with(mtcars, tapply(mpg, cyl, mean))

# %%
# Solution using the `sapply` and `split` functions:
sapply(split(mtcars$mpg, mtcars$cyl), mean)

# %% [markdown]
# ## Question 4

# %%
avg_hp <- tapply(mtcars$hp, mtcars$cyl, mean)
abs_diff <- abs(avg_hp[["4"]] - avg_hp[["8"]])
R.utils::printf("Absolute Difference = %f\n", abs_diff)
R.utils::printf("Rounded Absolute Difference = %d", round(abs_diff))
