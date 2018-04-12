library(subtools)
library(magrittr)

a <- read.subtitles.serie(dir = "subtitles/series/")
subtitles <- subDataFrame(a) 

subtitles %<>%
  select(-season_num, -serie) %>% 
  mutate(season = as.integer(season)) %>% 
  mutate(Text = sub("(!)|(\\.)|(\\?)|(\\.)|(\\-){1,}", "", tolower(Text))) %>% 
  mutate(key = gsub("(\\s|\\,)", "", Text))

rm(a)