library(tidyverse)
library(tidytext)
library(gender)

shows <- read_csv('data/lines.csv') %>%
  select(lines = X1) %>% 
  mutate(character = (sapply(strsplit(trimws(lines), ":"), "[", 1)),
         lines = (sapply(strsplit(trimws(lines), ":"), "[", 2)),
         lines = gsub('(\\[.*\\])', '', trimws(lines)),
         lines = gsub('(\\s{2,})', '', trimws(lines))) %>% 
  select(character, lines) %>% 
  filter(!grepl('dissolve|to|credits|title|they\'re|hallway|all|everyone|time', 
                tolower(character)),
         !is.na(character),
         character != "",
         grepl('^[A-Z{1,}].*', character),
         nchar(character) >= 3) %>% 
  mutate(lines = sub("(!)|(\\.)|(\\?)|(\\.)|(\\-){1,}", "", tolower(lines))) %>%
  mutaate(lines = gsub("\\'|\\.|\\,|\\;|\\'", "", lines)) %>% 
  mutate(key = gsub("(\\s|)", "", lines))
  

# Assign character genders
characterGender <- characters %>% 
  distinct(character) %>% 
  group_by(character) %>% 
  mutate(gender = gender(character)$gender[1]) %>% 
  mutate(gender = ifelse(tolower(character) == 'bulldog', 
                         "male", 
                         gender))

shows %<>%
  left_join(characterGender, by = "character")