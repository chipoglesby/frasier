library(subtools)
library(magrittr)

a <- read.subtitles.serie(dir = "data/subtitles/series/", encoding = "iso-8859-1")
subtitles <- subDataFrame(a)

subtitles %<>%
  rename(id = ID,
         text = Text,
         timecodeIn = Timecode.in,
         timecodeOut = Timecode.out,
         episode = episode_num) %>% 
  select(-season_num, -serie) %>%
  mutate(season = as.integer(season),
         text = sub("(!)|(\\.)|(\\?)|(\\.)|(\\-){1,}", "", tolower(text)),
         psuedoTimeIn = ymd_hms(strptime(timecodeIn, "%H:%M:%S")),
         psuedoTimeOut = ymd_hms(strptime(timecodeOut, "%H:%M:%S")),
         talkTime = psuedoTimeOut - psuedoTimeIn) %>% 
  filter(!grepl('www.|^#', tolower(text)))

rm(a)