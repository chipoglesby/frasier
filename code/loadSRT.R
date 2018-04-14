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
         episode = as.integer(episode),
         text = sub("(!)|(\\.)|(\\?)|(\\.)|(\\-){1,}", "", tolower(text))) %>% 
  filter(!grepl('www.|^#|^♪♪', tolower(text))) %>% 
  inner_join(seasons, by = c(season = "season",
                            episode = "episode")) %>% 
  mutate(dateTimeIn = ymd_hms(
    paste0(
      originalAirDate, 
      timecodeIn)),
    dateTimeOut = ymd_hms(
      paste0(
        originalAirDate, 
        timecodeOut)),
    talkTime = dateTimeOut - dateTimeIn)

rm(a)