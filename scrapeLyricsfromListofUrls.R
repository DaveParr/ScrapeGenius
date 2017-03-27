library(rvest)
library(stringr)

# turn Dave's lyric scrape into a function
extractLyrics <- function(track_url) {
  lyricText <- read_html(track_url)
  
  # after it's been scraped tell us so that we know somethings going on...
  print(paste(track_url, "has just been scraped"))
  # Pipe the info into slightly messy text file
  # need to remove more identifiers
  lyricText %>%
    html_node("lyrics") %>%
    html_text() %>%
    str_replace_all("\\n", " ")%>% # change line break to space
    str_replace_all("\\[.*?\\]", " ")  %>% #remove anything in []
    str_replace_all("([a-z])([A_Z])", "\\1 \\2") # fix wordRun on currently not working
}

# use the lappy function to scrape all the lyrics when
# supplied with a list of urls...
lyric_list <- lapply(songs_urls, extractLyrics)

# output the object
lyric_list

# check the length
length(lyric_list)

# and one of the parts...
lyric_list[2]
