# "Le Cigare Volant" (The Flying Cigar), "Chez Chez" and "Le Cochon Noir"
# Les Frères Heureux Timbermill Chicken Chicken Chicken
# https://www.reddit.com/r/Frasier/comments/4u4u6t/what_is_your_favorite_restaurant_from_frasier/
lines %>%
  filter(grepl('san gennaro|bavetta|au pied de cochon|espalier|volant|chez chez|cochon noir|heureux|chez henri|Anya|happy brothers|chicken chicken', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n) -> favoriteResturants

# Who talks about Sherry?
lines %>%
  filter(grepl('sherry', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n) -> sherryReferences

# Who talks about Coffee?
lines %>%
  filter(grepl('coffee|café|latte|nutmeg|nervosa', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n) -> coffeReferences

# Who talks about Eddie??
lines %>%
  filter(grepl('eddie', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n) -> edditReferences

# Who talks about beer?
lines %>%
  filter(grepl('beer', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n) -> beerReferences

# Who talks about Opera?
lines %>%
  filter(grepl('opera|theatre|theater', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n) -> operaReferences

# Who talks about Roz?
lines %>%
  filter(grepl('roz', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n) -> rozReferences

# Who talks about Daphne?
lines %>%
  filter(grepl('daphne', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n) -> daphneReferences

# Who talks about Maris?
lines %>%
  filter(grepl('maris', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n) -> marisReferences

# Who talks about Lilith?
lines %>%
  filter(grepl('lilith', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n) -> lilithReferences

# Which brother introduces themselves as doctor?
lines %>%
  filter(grepl('dr|doctor',
               tolower(lines)),
         grepl('frasier|niles',
               tolower(character))) %>%
  count(character, sort = TRUE) -> drReferences

# Who talks about mom the most?
# Which brother introduces themselves as doctor?
lines %>%
  filter(grepl('mom|mother',
               tolower(lines)),
         grepl('frasier|niles|martin',
               tolower(character))) %>%
  count(character, sort = TRUE) -> momReferences

# How many times does frasier say hello seattle or I'm listening?
lines %>%
  filter(grepl('i\'m listening|good mental health|wishing you',
               tolower(lines)),
         grepl('frasier',
               tolower(character))) %>%
  count(character, sort = TRUE) -> listeningReferences

# Is Frasier the only one who says DEAR GOD
lines %>%
  filter(grepl('dear god', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n) -> godReferences

lines %>%
  filter(!is.na(lines),
         grepl('frasier|roz|daphne|martin|niles|bulldog', 
               tolower(character))) %>%
  unnest_tokens(word, lines) %>%
  anti_join(stop_words) %>%
  count(character, word, sort = TRUE) %>%
  arrange(desc(n)) %>% 
  filter(n > 500) %>%
  ggplot(aes(n, word)) +
  geom_barh(stat = 'identity') +
  facet_wrap(~character, scales = 'free')