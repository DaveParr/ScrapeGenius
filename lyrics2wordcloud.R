# aim of this is to turn list of lyrics into a Wordcloud
# and a graph of frequency
# future usefulness unknow but there you go. 
# install.packages(c("wordcloud", "tm"))
  
library("wordcloud")
library("tm")
library("ggplot2")
library("RCurl")

# word clouds work best if we turn the text into a Corpus
# and then remove commons words and some punctuation

# starting point is object entitled lyric_list

# there is probably a better way to do this. 
text.comb <- NULL
for(i in 1:length(lyric_list)){
  text <- as.character(lyric_list[i])
  text.comb <- c(text.comb, text)
}

wordcloud(text.comb, 
          max.words = 35,
          random.order=FALSE, 
          rot.per=0.35, 
          use.r.layout=FALSE, 
          colors=brewer.pal(8, "Dark2"))

# "the" "you" - should be removed with stopWords


# layout is random... 

# convert into a Corpus - a structure for organising text...
text.c <- Corpus(VectorSource(text.comb))
text.c.p <- tm_map(text.c, content_transformer(tolower))
# remove stopwords
text.c.p <- tm_map(text.c.p, removeWords, stopwords("english"))

wordcloud(text.c.p, max.words = 35, colors=brewer.pal(8, "Dark2"))


# can remove some words
# remove more words
text.c.p <- tm_map(text.c.p, removeWords, c("got","just", "say", "can", 
                                            "like", "let", "want", "like", 
                                            "nice", "well", 
                                            "will", "now", "get", 
                                            "one"))

set.seed(501)  # stops the randomness of the plot
wordcloud(text.c.p, 
          max.words = 30,
          random.order=FALSE, 
          rot.per=0.35, 
          use.r.layout=FALSE, 
          colors=brewer.pal(8, "Dark2"))

# for more on word frequencies and a graph....... 

# create Document Term Matrix
dtm <- DocumentTermMatrix(text.c.p)

# Plotting Word Frequencies
freq <- sort(colSums(as.matrix(dtm)), decreasing = TRUE)
head(freq, 14)

# make the data frame for ggplot
wf <- data.frame(word = names(freq), freq = freq)
head(wf,20)

wf.freq <- subset(wf, freq > 20) # data frame with abundant words - 23 words

p <-  ggplot(wf.freq, aes(word, freq)) + 
  geom_bar(stat="identity") +
  xlab("Frequent words") +   # label x-axis
  ylab("Frequency") +    # label y-axis
  ggtitle("Word Frequencies in my tweets") +
  theme_bw() +
  theme(axis.text.x = element_text(angle=45, hjust=1)) 

p  # show the object...

