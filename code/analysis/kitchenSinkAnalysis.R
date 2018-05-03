# "Le Cigare Volant" (The Flying Cigar), "Chez Chez" and "Le Cochon Noir"
# Les Frères Heureux Timbermill Chicken Chicken Chicken
# https://www.reddit.com/r/Frasier/comments/4u4u6t/what_is_your_favorite_restaurant_from_frasier/
transcripts %>%
  filter(grepl('san gennaro|bavetta|au pied de cochon|espalier|volant|chez chez|cochon noir|heureux|chez henri|Anya|happy brothers|chicken chicken', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n) -> favoriteResturants

# Who talks about Sherry?
transcripts %>%
  filter(grepl('sherry', tolower(lines)),
         grepl('frasier|niles', tolower(character))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n) -> sherryReferences

# Who talks about Coffee?
transcripts %>%
  filter(grepl('coffee|café|latte|nutmeg|nervosa', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n) -> coffeReferences

# Who talks about Eddie??
transcripts %>%
  filter(grepl('eddie', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n) -> edditReferences

# Who talks about beer?
transcripts %>%
  filter(grepl('beer', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n) -> beerReferences

# Who talks about Opera?
transcripts %>%
  filter(grepl('opera|theatre|theater', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n) -> operaReferences

# Who talks about Roz?
transcripts %>%
  filter(grepl('roz', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n) -> rozReferences

# Who talks about Daphne?
transcripts %>%
  filter(grepl('daphne', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n) -> daphneReferences

# Who talks about Maris?
transcripts %>%
  filter(grepl('maris', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n) -> marisReferences

# Who talks about Lilith?
transcripts %>%
  filter(grepl('lilith', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n) -> lilithReferences

# Which brother introduces themselves as doctor?
transcripts %>%
  filter(grepl('dr|doctor',
               tolower(lines)),
         grepl('frasier|niles',
               tolower(character))) %>%
  count(character, sort = TRUE) -> drReferences

# Who talks about mom the most?
# Which brother introduces themselves as doctor?
transcripts %>%
  filter(grepl('mom|mother',
               tolower(lines)),
         grepl('frasier|niles|martin',
               tolower(character))) %>%
  count(character, sort = TRUE) -> momReferences

# How many times does frasier say hello seattle or I'm listening?
transcripts %>%
  filter(grepl('i\'m listening|good mental health|wishing you',
               tolower(lines)),
         grepl('frasier',
               tolower(character))) %>%
  count(character, sort = TRUE) -> listeningReferences

# Is Frasier the only one who says DEAR GOD
transcripts %>%
  filter(grepl('dear god', tolower(lines))) %>%
  count(character, sort = TRUE) %>%
  top_n(5, n) -> godReferences

transcripts %>%
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