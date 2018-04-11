library(tidyverse)
shows <- read_csv('data/lines.csv') %>%
  select(lines = X1) %>% 
  mutate(character = (sapply(strsplit(trimws(lines), ":"), "[", 1)),
         lines = (sapply(strsplit(trimws(lines), ":"), "[", 2)),
         lines = gsub('(\\[.*\\])', '', trimws(lines)),
         lines = gsub('(\\s{2,})', '', trimws(lines))) %>% 
  select(character, lines) %>% 
  filter(!grepl('dissolve|to|credits', tolower(character)))

# Quickly find top characters:

characters <- shows %>% 
  count(character, sort = TRUE)

# "Le Cigare Volant" (The Flying Cigar), "Chez Chez" and "Le Cochon Noir"
shows %>% 
  filter(grepl('volant|chez chez|cochon noir', tolower(lines))) %>% 
  count(character, sort = TRUE) %>% 
  top_n(5, n)

# Who talks about Sherry?
shows %>% 
  filter(grepl('sherry', tolower(lines))) %>% 
  count(character, sort = TRUE) %>% 
  top_n(5, n)

# Who talks about beer?
shows %>% 
  filter(grepl('beer', tolower(lines))) %>% 
  count(character, sort = TRUE) %>% 
  top_n(5, n)

# Who talks about Roz?
shows %>% 
  filter(grepl('roz', tolower(lines))) %>% 
  count(character, sort = TRUE) %>% 
  top_n(5, n)

# Who talks about Daphne?
shows %>% 
  filter(grepl('daphne', tolower(lines))) %>% 
  count(character, sort = TRUE) %>% 
  top_n(5, n)

# Who talks about Maris?
shows %>% 
  filter(grepl('maris', tolower(lines))) %>% 
  count(character, sort = TRUE) %>% 
  top_n(5, n)

# Who talks about Lilith?
shows %>% 
  filter(grepl('lilith', tolower(lines))) %>% 
  count(character, sort = TRUE) %>% 
  top_n(5, n)