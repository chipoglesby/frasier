# "Le Cigare Volant" (The Flying Cigar), "Chez Chez" and "Le Cochon Noir"
# Les Frères Heureux Timbermill Chicken Chicken Chicken
# https://www.reddit.com/r/Frasier/comments/4u4u6t/what_is_your_favorite_restaurant_from_frasier/
lines %>%
  filter(grepl('volant|chez chez|cochon noir|heureux|chez henri|Anya|happy brothers|chicken chicken', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n)

# Who talks about Sherry?
lines %>%
  filter(grepl('sherry', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n)

# Who talks about Coffee?
lines %>%
  filter(grepl('coffee|café|latte|nutmeg|nervosa', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n)

# Who talks about Eddie??
lines %>%
  filter(grepl('eddie', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n)

# Who talks about beer?
lines %>%
  filter(grepl('beer', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n)

# Who talks about Opera?
lines %>%
  filter(grepl('opera|theatre|theater', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n)

# Who talks about Roz?
lines %>%
  filter(grepl('roz', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n)

# Who talks about Daphne?
lines %>%
  filter(grepl('daphne', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n)

# Who talks about Maris?
lines %>%
  filter(grepl('maris', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n)

# Who talks about Lilith?
lines %>%
  filter(grepl('lilith', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n)

# Which brother introduces themselves as doctor?
lines %>%
  filter(grepl('dr|doctor',
               tolower(lines)),
         grepl('frasier|niles',
               tolower(character))) %>%
  count(character, sort = TRUE)

# Who talks about mom the most?
# Which brother introduces themselves as doctor?
lines %>%
  filter(grepl('mom|mother',
               tolower(lines)),
         grepl('frasier|niles|martin',
               tolower(character))) %>%
  count(character, sort = TRUE)

# How many times does frasier say hello seattle or I'm listening?
lines %>%
  filter(grepl('i\'m listening|good mental health|wishing you',
               tolower(lines)),
         grepl('frasier',
               tolower(character))) %>%
  count(character, sort = TRUE)

# Is Frasier the only one who says DEAR GOD
lines %>%
  filter(grepl('dear god', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n)

lines %>%
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


lines %>% 
  filter(grepl('good lord|dear god|dear lord', lines)) %>% 
  tally()

lines %>% 
  filter(grepl('gods sake', lines)) %>% 
  tally()

lines %>% 
  filter(grepl('good lord', lines)) %>% 
  tally()
