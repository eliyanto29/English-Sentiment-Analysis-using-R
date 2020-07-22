###################################################################################################
#----------------------------------------Crawling Data Twitter------------------------------------#
#--------------------------------------------Joko Eliyanto----------------------------------------#
###################################################################################################

#----------------------------------Install package jika diperlukan--------------------------------#
#install.packages("here")
#install.packages("twitteR")
#install.packages("ROAuth")
#install.packages("RCurl")

#---------------------------------------Mengaktifkan Library--------------------------------------#
library(here)
library(twitteR)
library(ROAuth)
library(RCurl)

#Note:   Menentukan folder kerja
setwd(here())

#Note:   Download sertifikat dari curl
download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.pem")

#Note:   Meminta izin kepada twitter
requrl <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
CUSTOMER_KEY <- "q4JV81cT8nOuq7vQEhh8Blyt7"
CUSTOMER_SECRET <- "vm25rZY73JfeRMo7p1pv1nquXrNj91LHAYpu083RAkD4p6PBsA"
ACCES_TOKEN <- "955350081544142848-uDwUVnX6S5MyFSPV2UAM3YeTSvGWGbI"
ACCES_secret <- "rXjsaSGUubbbNRowju3GAbojGBubxCsVq3M8QgHt3rxvQ"

#Note:   Men-setup authorisasi
setup_twitter_oauth(CUSTOMER_KEY, CUSTOMER_SECRET, ACCES_TOKEN, ACCES_secret)
1

#Note:   Mengambil data dari twitter

bd<-searchTwitter('covid19', n=200, lang='id', locale=TRUE)
df_id<-do.call("rbind", lapply(bd, as.data.frame))
View(df_id)

#Note:   Mengeksport ke dalam csv file
write.csv(df_id, file='F:/TUGAS/pemilu.csv', row.names = F)

#Note:   Mengambil Twiter berdasarkan range waktu
pemiluapril2019<-searchTwitter('covid19',since="2020-6-1", until="2020-6-30")
df_id<-do.call("rbind", lapply(pemiluapril2019, as.data.frame))
View(df_id)

#Note:   Mengeksport ke dalam csv file
write.csv(df_id, file='F:/TUGAS/pemilu2.csv', row.names = F)