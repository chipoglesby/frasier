library(tidyverse)

testSRT <- episodes %>%
  filter(!is.na(key)) %>%
  inner_join(subtitles, by = "key") %>%
  distinct(key, .keep_all = TRUE) %>%
  select(-Text, -key)

testSRTAlternative <- episodes %>%
  filter(!is.na(key)) %>%
  inner_join(subtitles, by = "key")

multiples <- testSRTAlternative %>%
  count(lines, sort = TRUE) %>%
  top_n(10)

testSRT %>%
  count(season, character, sort = TRUE) %>%
  filter(n > 30) %>%
  ggplot(aes(character, n)) +
  geom_bar(stat = 'identity') +
  facet_wrap(~season, scales = "free")

testSRT %>%
  count(season)

episodes %>%
  filter(!is.na(gender)) %>% 
  count(gender)

test <- episodes %>%
  left_join(subtitles, by = "key") %>% 
  mutate(season = ifelse(is.na(season), lag(season), season))
