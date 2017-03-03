library(rvest)
library(stringr)

# Input url for traCK
track_url <- rvest::html("https://genius.com/Eminem-rap-god-lyrics")

# Pipe the info into slightly messy text file
# need to remove more identifiers
track_url %>%
  html_node("lyrics") %>%
  html_text() %>%
  str_replace_all("\\n", " ")%>% # change line break to space
  str_replace_all("\\[.*?\\]", " ") %>% #remove anything in []
  str_replace_all("([a-z])([A_Z])", "\\1 \\2") # fix wordRun on currently not working
