library(RSQLite)
con <- RSQLite::dbConnect(drv    = SQLite(), 
                          dbname = "00_data/02_chinook/Chinook_Sqlite.sqlite")
dbListTables(con)#returns the names of the tables that are available
tbl(con, "Album")#to examine a table from a Database, its is an DPLYR package
album_tbl <- tbl(con, "Album") %>% collect()#to pull the data into a local memory
dbDisconnect(con)
con#to disconnect the database after data acquisiton is done
#Glue Package
library(glue)
name <- "Fred"
glue('My name is {name}.')
library(httr)
resp <- GET("https://swapi.dev/api/people/1/")

# Wrapped into a function
sw_api <- function(path) {
  url <- modify_url(url = "https://swapi.dev", path = glue("/api{path}"))
  resp <- GET(url)
  stop_for_status(resp) # automatically throws an error if a request did not succeed
}

resp <- sw_api("/people/1")
resp
rawToChar(resp$content)#to convert the rawunicode into a character vector
#From a character vector, we can convert it into list data structure using the fromJSON() function from the jsonlite library. We can use toJSON() to convert something back to the original JSON structure.
#RLists: contains objects of various types
#a list is created using list()
data_list <- list(strings= c("string1", "string2"), 
                  numbers = c(1,2,3), 
                  TRUE, 
                  100.23, 
                  tibble(
                    A = c(1,2), 
                    B = c("x", "y")
                  )
)
library(jsonlite)
resp %>% 
  .$content %>% 
  rawToChar() %>% 
  fromJSON()

#content(resp, as = "text")
#content(resp, as = "parsed")
#content(resp)#content of an API response can beaccessed using the following above
resp <- GET('https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=WDI.DE')
resp
#API Key
token    <- "my_individual_token"
response <- GET(glue("https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=WDI.DE&apikey={token}"))
response

#Securing Credentials: option 1 Environment variables using the .Renviron file
#Option 2: Encrypt credentials with the keyring package
#option 3: Prompt for credentials using the RStudio IDE.