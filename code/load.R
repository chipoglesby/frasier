library(tidyverse)
shows <- read_csv('scripts/test.csv') %>%
  select(lines = X1) %>% 
  mutate(character = (sapply(strsplit(trimws(lines), ":"), "[", 1)),
         lines = (sapply(strsplit(trimws(lines), ":"), "[", 2)),
         lines = gsub('(\\[.*\\])', '', trimws(lines)),
         lines = gsub('(\\s{2,})', '', trimws(lines))) %>% 
  select(character, lines)