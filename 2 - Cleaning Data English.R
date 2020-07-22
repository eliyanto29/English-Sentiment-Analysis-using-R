###################################################################################################
#----------------------------------------DATA CLEANING ENGLISH------------------------------------#
#--------------------------------------------Joko Eliyanto----------------------------------------#
###################################################################################################

#Note:    Mengaktifkan Library
library(tidyverse)
library(tm)
library(e1071)
library(caret)
library(textclean)
library(here)

#Note:      Menentukan folder kerja
setwd("F:/Canel HOBI DATA/Sentiment Analysis")

#Note:      Membuka dataset
myDataset <- read.csv("Tweets.csv", stringsAsFactors = FALSE)
glimpse(myDataset)

#Note:      Memilih data cuitan Tweeter
tweets <- myDataset$text

#Note:      Mengubah teks menjadi character
tweets <- tweets %>% 
  as.character()

#Note:      Menghapus karakter "\n"
tweets <- gsub( "\n "," ",tweets)

myDataset$text[100]
tweets[100]

#Note:      Menghapus karakter html & url
tweets <- tweets %>% 
  replace_html() %>%  
  replace_url() 

myDataset$text[100]
tweets[100]

#Note:      Menghapus emoji dan karakter emoji
tweets <- tweets %>% 
  replace_emoji(.) %>% 
  replace_html(.)

myDataset$text[9]
tweets[9]
#Note:      Menghapus mention(@[...])  dan tagar(#[...])
tweets <- tweets %>% 
  replace_tag(tweets, pattern = "@([A-Za-z0-9_]+)",replacement="") %>%  
  replace_hash(tweets, pattern = "#([A-Za-z0-9_]+)",replacement="")     

#Note:      Menghilangkan tanda baca
tweets <- removePunctuation(tweets)

myDataset$text[174]
tweets[174]

#Note:      Menghapus kata-kata slang
#Note:      Mengimpor himpunan kata-kata slang

tweets <- replace_internet_slang(tweets, slang = paste0("\\b",
                                                   lexicon::hash_internet_slang[[1]], "\\b"),
                                 replacement = lexicon::hash_internet_slang[[2]], ignore.case = TRUE)
myDataset$text[134]
tweets[134]

#Note:      Menghilangkan stopwords
tweets <- as.character(tweets)
tweets<-removeWords(tweets, stopwords(kind='en'))

myDataset$text[134]
tweets[134]

#Note:      Mengubah kata-kata ke bentuk kata dasar(Cth: loving ==> love)

tweets   <- stemDocument(tweets)

#Note:      Mengubah karakter menjadi huruf kecil
tweets <- tolower(tweets)

myDataset$text[186]
tweets[186]

#Note:      Menghilangkan huruf "rt[spasi]"
tweets <- gsub("rt ", "",tweets)
tweets <- gsub("cc ", "",tweets)

myDataset$text[1]
tweets[1]

#Note:      Membuat karakter yang strip(menghapus angka & karakter lain selain huruf)
tweets <- strip(tweets)
myDataset$text[19]
tweets[19]

#Note:      Menghilangkan twitter yang sama
tweets <- tweets[!duplicated(tweets)]

#Note:      Mengeksport ke dalam csv file
write.csv(tweets, file="F:/Canel HOBI DATA/Sentiment Analysis/Tweets_clean.csv", row.names = F)
#------------------------------------------------------------------------------------------------#

