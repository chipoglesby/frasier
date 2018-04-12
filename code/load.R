library(tidyverse)
library(tidytext)

shows <- read_csv('data/lines.csv') %>%
  select(lines = X1) %>% 
  mutate(character = (sapply(strsplit(trimws(lines), ":"), "[", 1)),
         lines = (sapply(strsplit(trimws(lines), ":"), "[", 2)),
         lines = gsub('(\\[.*\\])', '', trimws(lines)),
         lines = gsub('(\\s{2,})', '', trimws(lines))) %>% 
  select(character, lines) %>% 
  filter(!grepl('dissolve|to|credits|title|they\'re|hallway|all|everyone', 
                tolower(character)),
         !is.na(character),
         character != "",
         grepl('^[A-Z{1,}].*', character),
         nchar(character) >= 3)

# Quickly find top characters:
characters <- shows %>% 
  count(character, sort = TRUE) %>%
  top_n(100, n)

# "Le Cigare Volant" (The Flying Cigar), "Chez Chez" and "Le Cochon Noir"
# Les Frères Heureux Timbermill Chicken Chicken Chicken
# https://www.reddit.com/r/Frasier/comments/4u4u6t/what_is_your_favorite_restaurant_from_frasier/
shows %>% 
  filter(grepl('volant|chez chez|cochon noir|heureux|chez henri|Anya|happy brothers|chicken chicken', tolower(lines))) %>% 
  count(character, sort = TRUE) %>% 
  top_n(5, n)

# Who talks about Sherry?
shows %>% 
  filter(grepl('sherry', tolower(lines))) %>% 
  count(character, sort = TRUE) %>% 
  top_n(5, n)

# Who talks about Coffee?
shows %>% 
  filter(grepl('coffee|café|latte|nutmeg|nervosa', tolower(lines))) %>% 
  count(character, sort = TRUE) %>% 
  top_n(5, n)

# Who talks about Eddie??
shows %>% 
  filter(grepl('eddie', tolower(lines))) %>% 
  count(character, sort = TRUE) %>% 
  top_n(5, n)

# Who talks about beer?
shows %>% 
  filter(grepl('beer', tolower(lines))) %>% 
  count(character, sort = TRUE) %>% 
  top_n(5, n)

# Who talks about Opera?
shows %>% 
  filter(grepl('opera|theatre|theater', tolower(lines))) %>% 
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

# Which brother introduces themselves as doctor?
shows %>% 
  filter(grepl('dr|doctor', 
               tolower(lines)),
         grepl('frasier|niles',
               tolower(character))) %>%
  count(character, sort = TRUE)

# Who talks about mom the most?
# Which brother introduces themselves as doctor?
shows %>% 
  filter(grepl('mom|mother', 
               tolower(lines)),
         grepl('frasier|niles|martin',
               tolower(character))) %>%
  count(character, sort = TRUE)

# How many times does frasier say hello seattle or I'm listening?
shows %>% 
  filter(grepl('i\'m listening|good mental health|wishing you', 
               tolower(lines)),
         grepl('frasier',
               tolower(character))) %>%
  count(character, sort = TRUE)

# Is Frasier the only one who says DEAR GOD
shows %>% 
  filter(grepl('dear god', tolower(lines))) %>% 
  count(character, sort = TRUE) %>% 
  top_n(5, n)

shows %>%
  # filter(grepl('roz', tolower(character))) %>%
  filter(!is.na(lines)) %>% 
  # group_by(character) %>% 
  unnest_tokens(word, lines) %>%
  anti_join(stop_words) %>%
  count(word, sort = TRUE) %>%
  filter(n > 500) %>% 
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip()