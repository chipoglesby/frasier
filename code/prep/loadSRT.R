library(subtools)
library(magrittr)

a <- read.subtitles.serie(dir = "data/subtitles/series/", encoding = "iso-8859-1")
subtitles <- subDataFrame(a)

song <- paste0("frasier has left the building|\\[organ music playing\\]|scrambled eggs all over my face|good night, seattle, we love you|good night, everybody|frasier has left the building|hey, baby, i hear the blues a'callin'|tossed salads and scrambled eggs|
mercy â\u0099ª|and maybe i seem a bit confused|well, maybe, but i got you 
               pegged|but i don't know what to do|with those tossed salads and 
               scrambled eggs|they're callin' again|http\\:|good night we love you|â|â|ªâ|â|â")

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
    talkTime = dateTimeOut - dateTimeIn) %>% 
  filter(!grepl(song, tolower(text)))

subtitles %>% 
  write_csv('data/csv/subtitles.csv') %>% 
  saveRDS(., file = 'data/rds/subtitles.rds')

rm(a)
rm(song)