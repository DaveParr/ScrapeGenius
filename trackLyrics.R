library(rvest)

# Input url for traCK
track_url <- rvest::html("https://genius.com/Eminem-rap-god-lyrics")

# Pipe the info into slightly messy text file
track_url %>% html_node("lyrics") %>% html_text()
