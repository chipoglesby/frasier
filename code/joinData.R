library(tidyverse)

episodes %<>% 
  left_join(seasons, by = c(season = "season",
                             episode = "episode"))

subtitles %<>% 
  left_join(seasons, by = c(season = "season",
                             episode = "episode")) %>% 
  mutate(psuedoTimeIn = ymd_hms(
    paste0(
      originalAirDate, 
      timecodeIn)),
    psuedoTimeOut = ymd_hms(
      paste0(
        originalAirDate, 
        timecodeOut)))