library(tidyverse)

combiningData <- episodes %>%
  filter(!is.na(key)) %>%
  inner_join(subtitles, by = c("key" = "key", 
                               "season" = "season",
                               "episode" = "episode_num")) %>%
  distinct(key, .keep_all = TRUE) %>%
  select(-Text, -key) %>% 
  mutate(lines = gsub('[[:punct:]]', '', lines))

combiningDataAlternative <- episodes %>%
  filter(!is.na(key)) %>%
  inner_join(subtitles, by = "key")

multiples <- combiningDataAlternative %>%
  count(lines, sort = TRUE) %>%
  top_n(10)

combiningData %>%
  count(season, character, sort = TRUE) %>%
  filter(n > 30) %>%
  ggplot(aes(character, n)) +
  geom_bar(stat = 'identity') +
  facet_wrap(~season, scales = "free")

combiningData %>%
  count(season)

episodes %>%
  filter(!is.na(gender)) %>% 
  count(gender)