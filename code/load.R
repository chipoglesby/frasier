library(tidyverse)
library(tidytext)
library(gender)

episodes <- read_csv('data/csv/lines.csv',
                  col_names = c('lines', 'seasonEpisode')) %>%
  mutate(character = (sapply(strsplit(trimws(lines), ":"), "[", 1)),
         lines = (sapply(strsplit(trimws(lines), ":"), "[", 2)),
         lines = gsub('(\\[.*\\])', '', trimws(lines)),
         lines = gsub('(\\s{2,})', '', trimws(lines)),
         season = substr(seasonEpisode, 0, 2),
         episode = substr(seasonEpisode, 3, 4)) %>%
  select(character, lines, season, episode) %>%
  filter(!grepl('dissolve|to|credits|title|they\'re|hallway|all|everyone|time',
                tolower(character)),
         !is.na(character),
         character != "",
         grepl('^[A-Z{1,}].*', character),
         nchar(character) >= 3) %>%
  mutate(lines = sub("(!)|(\\.)|(\\?)|(\\.)|(\\-){1,}", "", tolower(lines))) %>%
  mutate(lines = gsub("\\'|\\.|\\,|\\;|\\'", "", lines)) %>%
  mutate(key = gsub("(\\s|)", "", lines),
         key = gsub('[[:punct:]]', '', key))

# Quickly find top characters:
characters <- episodes %>%
  count(character, sort = TRUE)

# Assign character genders
characterGender <- characters %>%
  distinct(character) %>%
  group_by(character) %>%
  mutate(gender = gender(character)$gender[1]) %>%
  mutate(gender = ifelse(tolower(character) == 'bulldog',
                         "male",
                         gender))

episodes %<>%
  left_join(characterGender, by = "character")
