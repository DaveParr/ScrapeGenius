library(rvest)

# start Sun 19:10

# can I make a work cloud of some eminem lyrics?

# so code above works well to get the lyrics of a single song. 

# https://genius.com/search?q=eminem gives list of eminem songs. 
url <- c("https://genius.com/search?q=eminem")
# N.B. ONLY GIVES 10 songs... WHY? Something to do with Search...

# this readLines() function is a base R function which allows reading webpages
data <- readLines(url)
print(paste(url, "has just been scraped"))

# identify where the lyrics urls are on the scraped data
lyrics_numbers <- grep("-lyrics", data)

extractSongUrl <- function(htmlString) {
  htmlString <- gsub("<a href=", "", htmlString)
  htmlString <- gsub("class.*", "", htmlString)
  htmlString <- gsub("*.https", "https", htmlString)
  htmlString <- gsub("lyrics.*", "lyrics", htmlString)
  return(htmlString)
}
# extractSongUrl(data[310]) # test


songs_urls <- NULL
for(i in 1:length(lyrics_numbers)){
  reqd_url <- extractSongUrl(data[lyrics_numbers[i]])
  songs_urls <- c(songs_urls, reqd_url)
}

# object is a list of urls 
# used in next script: scrapeLyricsfromListofUrls



