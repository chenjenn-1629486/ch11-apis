# Exercise 2: working with data APIs

# load relevant libraries
library(httr)
library(jsonlite)

# Use `source()` to load your API key variable from the `apikey.R` file you made.
# Make sure you've set your working directory!
source("apikey.R")

# Create a variable `movie.name` that is the name of a movie of your choice.
movie.name <- "Grease"

# Construct an HTTP request to search for reviews for the given movie.
# The base URI is `https://api.nytimes.com/svc/movies/v2/`
# The resource is `reviews/search.json`
# See the interactive console for parameter details:
#   https://developer.nytimes.com/movie_reviews_v2.json
#
# You should use YOUR api key (as the `api-key` parameter)
# and your `movie.name` variable as the search query!
base.uri <- "https://api.nytimes.com/svc/movies/v2/"
resource <- "reviews/search.json"
uri.full <- paste0(base.uri, resource)
query.params <- list("api-key" = nyt_apikey, query = movie.name)
response <- GET(uri.full, query = query.params)

# Send the HTTP Request to download the data
# Extract the content and convert it from JSON
response.content <- content(response, "text")
body.data <- fromJSON(response.content)

# What kind of data structure did this produce? A data frame? A list?
is.data.frame(body.data)
is.list(body.data)
# Manually inspect the returned data and identify the content of interest 
# (which are the movie reviews).
# Use functions such as `names()`, `str()`, etc.
str(body.data)
names(body.data)
names(body.data$results)
# Flatten the movie reviews content into a data structure called `reviews`
reviews <- flatten(body.data$results)

# From the most recent review, store the headline, short summary, and link to
# the full article, each in their own variables
first_review <- reviews[1, ]

# Create a list of the three pieces of information from above. 
# Print out the list.
