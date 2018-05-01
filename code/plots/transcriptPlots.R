# Box plot of line counts men vs women by season
transcripts %>%
  filter(gender != 'other') %>% 
  mutate(season = as.factor(season),
         episode = as.factor(episode)) %>% 
  group_by(gender, 
           season, 
           episode) %>%
  summarize(lineCount = n()) %>% 
  ggplot(aes(gender, 
             lineCount,
             fill = gender)) +
  geom_boxplot() +
  facet_wrap(~season, 
             scales = 'free') +
  ggtitle('Boxplot: Lines Count Men vs Women') +
  xlab('Gender') +
  ylab('Line Count')

# Box plots of line counts men vs women by Character Type
transcripts %>%
  filter(gender != 'other') %>% 
  mutate(season = as.factor(season),
         episode = as.factor(episode)) %>% 
  group_by(gender, 
           season, 
           episode,
           characterType) %>%
  summarize(lineCount = n()) %>% 
  ggplot(aes(gender, 
             lineCount,
             fill = gender)) +
  geom_boxplot() +
  ggtitle('Boxplot: Lines Count Men vs Women') +
  xlab('Gender') +
  ylab('Line Count') +
  facet_wrap(~characterType, scales = 'free')

transcripts %>%
  filter(characterType == 'main') %>% 
  mutate(season = as.factor(season),
         episode = as.factor(episode)) %>% 
  group_by(character, 
           season, 
           episode) %>%
  summarize(lineCount = n()) %>% 
  ggplot(aes(character, 
             lineCount,
             fill = character)) +
  geom_boxplot() +
  facet_wrap(~season, 
             scales = 'free') +
  ggtitle('Boxplot: Lines Count of Main Characters') +
  xlab('Character') +
  ylab('Line Count')

transcripts %>%
  filter(characterType == 'main') %>% 
  group_by(character) %>%
  summarize(lineCount = n(),
            total = sum(lineCount),
            lineShare = sum(lineCount/total)) %>%
  mutate(total = sum(lineCount),
         lineShare = lineCount/total) %>% 
  ggplot(aes(character, 
             lineShare,
             fill = character)) +
  geom_bar(stat = 'identity') +
  ggtitle('Line Share of Main Characters') +
  xlab('Character') +
  ylab('Line Share')

# Line Share By Character Type
transcripts %>%
  group_by(characterType) %>%
  summarize(lineCount = n(),
            total = sum(lineCount),
            lineShare = sum(lineCount/total)) %>%
  mutate(total = sum(lineCount),
         lineShare = lineCount/total) %>% 
  ggplot(aes(characterType, 
             lineShare,
             fill = characterType)) +
  geom_bar(stat = 'identity') +
  ggtitle('Line Share of Character Types') +
  xlab('Character Type') +
  ylab('Line Share')

# Line Share By Gender
transcripts %>%
  group_by(gender) %>%
  summarize(lineCount = n(),
            total = sum(lineCount),
            lineShare = sum(lineCount/total)) %>%
  mutate(total = sum(lineCount),
         lineShare = lineCount/total) %>% 
  ggplot(aes(gender, 
             lineShare,
             fill = gender)) +
  geom_bar(stat = 'identity') +
  ggtitle('Line Share of Gender Types') +
  xlab('Gender') +
  ylab('Line Share')

# Line Share By Main Character
transcripts %>%
  filter(characterType == 'main') %>% 
  group_by(episodeCount,
           characterName) %>% 
  summarize(lines = n()) %>% 
  ggplot(aes(episodeCount,
             lines,
             color = characterName)) +
  geom_smooth(se = FALSE) +
  xlab('Episode') +
  ylab('Lines') +
  ggtitle('Lines Per Main Character')

### Words
# Top main words by main characters
tidyTranscript %>% 
  group_by(characterName,
           characterType,
           word) %>% 
  summarize(wordCount = n()) %>%
  ungroup() %>% 
  mutate(percent = wordCount/sum(wordCount)) %>% 
  arrange(desc(percent)) %>% 
  group_by(characterName) %>% 
  top_n(10, wordCount) %>%
  filter(characterType == 'main') %>% 
  ggplot(aes(word, wordCount)) +
  geom_bar(stat = 'identity') +
  facet_wrap(~characterName, scales = 'free') +
  xlab('Word Count') +
  ylab('Word') +
  ggtitle('Top Words By Main Characters')

# Mean Words Per Character
tidyTranscript %>% 
  distinct(characterName, 
           characterType,
           episodeCount,
           word) %>% 
  mutate(meanLettersPerWord = nchar(word)) %>% 
  group_by(characterName,
           characterType,
           episodeCount) %>% 
  summarize(meanLettersPerWord = mean(meanLettersPerWord)) %>% 
  arrange(desc(meanLettersPerWord)) %>% 
  filter(characterType == 'main') %>% 
  # spread(episodeCount, meanLettersPerWord, fill = 0) -> meanLettersPerWord
  ggplot(aes(episodeCount, meanLettersPerWord, color = characterName)) +
  geom_smooth(se = FALSE) +
  xlab('Episode') +
  ylab('Mean Letters Per Word') +
  ggtitle('Mean Letters Per Word By Character')

# Word Count Per Episode
wordCountPerEpisode %>% 
  filter(character == 'Frasier') %>% 
  ggplot(aes(episodeCount, 
             nn,
             color = character)) +
  geom_smooth() +
  geom_line() +
  xlab('Episode') +
  ylab('Word Count') +
  ggtitle("Word Count Per Episode") +
  facet_wrap(~character)


### Sentiment
# Sentiment of Main Characters
mainCharacterSentiment %>% 
  ggplot(aes(episodeCount, 
             sentiment)) +
  geom_smooth() + 
  geom_line() +
  facet_wrap(~characterName) +
  ylab('Sentiment') +
  xlab('Episode') +
  ggtitle('Frasier: Sentiment of Main Characters')


## Working:
tidyTranscripts %>% 
  filter(characterType == 'main') %>% 
  count(characterName, 
        season) %>% 
  ggplot(aes(season, 
             n, 
             fill = characterName)) +
  geom_bar(stat = 'identity', 
           show.legend = FALSE) +
  scale_x_continuous(
    breaks = c(1:max(tidyTranscripts$season))) +
  facet_wrap(~characterName) +
  ggtitle('Total Words Per Main Character') +
  xlab('Season') +
  ylab('Word Count')

tidyTranscripts %>%
  filter(gender != 'other') %>% 
  count(gender, 
        season) %>% 
  ggplot(aes(season, 
             n, 
             fill = gender)) +
  geom_bar(stat = 'identity', 
           show.legend = FALSE) +
  scale_x_continuous(
    breaks = c(1:max(tidyTranscripts$season))) +
  facet_wrap(~gender) +
  ggtitle('Total Words Per Gender') +
  xlab('Season') +
  ylab('Word Count')


tidyTranscripts %>%
  filter(characterType != 'other') %>% 
  count(characterType, 
        season) %>% 
  ggplot(aes(season, 
             n, 
             fill = characterType)) +
  geom_bar(stat = 'identity', 
           show.legend = FALSE) +
  scale_x_continuous(
    breaks = c(1:max(tidyTranscripts$season))) +
  facet_wrap(~characterType) +
  ggtitle('Total Words Per Character Type') +
  xlab('Season') +
  ylab('Word Count')


tidyTranscripts %>% 
  filter(characterType != 'other') %>% 
  count(characterName, 
        episodeCount) %>% 
  ggplot(aes(episodeCount, 
             n, 
             color = characterName)) +
  # geom_bar(stat = 'identity', 
  #         show.legend = FALSE) +
  geom_smooth(se = FALSE, method = 'lm', show.legend = FALSE) +
  # scale_x_continuous(
  #  breaks = c(1:max(tidyTranscripts$episodeCount))) +
  facet_wrap(~characterName) +
  ggtitle('Total Words Per Main Character') +
  xlab('episodeCount') +
  ylab('Word Count')

tidyTranscripts %>%
  filter(gender != 'other') %>% 
  count(gender, 
        episodeCount) %>% 
  ggplot(aes(episodeCount, 
             n, 
             color = gender)) +
  # geom_bar(stat = 'identity', 
  #          show.legend = FALSE) +
  # scale_x_continuous(
  #   breaks = c(1:max(tidyTranscripts$episodeCount))) +
  geom_smooth(se = FALSE, method = 'lm') +
  facet_wrap(~gender) +
  ggtitle('Total Words Per Gender') +
  xlab('episodeCount') +
  ylab('Word Count')


tidyTranscripts %>%
  filter(characterType != 'other') %>% 
  count(characterType, 
        episodeCount) %>% 
  ggplot(aes(episodeCount, 
             n, 
             color = characterType)) +
  # geom_bar(stat = 'identity', 
  #          show.legend = FALSE) +
  # scale_x_continuous(
  #   breaks = c(1:max(tidyTranscripts$episodeCount))) +
  geom_smooth(se = FALSE, method = 'lm') +
  facet_wrap(~characterType) +
  ggtitle('Total Words Per Character Type') +
  xlab('episodeCount') +
  ylab('Word Count')

tidyTranscripts %>% 
  filter(!is.na(characterName)) %>% 
  group_by(characterName) %>% 
  summarize(n = n_distinct(season)) %>% 
  arrange(desc(n)) %>% 
  filter(n >= 8) %>% 
  left_join(tidyTranscripts) %>% 
  select(-n) %>% 
  count(characterName, 
        season) %>% 
  ggplot(aes(season, 
             n, 
             fill = characterName)) +
  geom_bar(stat = 'identity',
           show.legend = FALSE) + 
  geom_smooth(se = FALSE, 
              show.legend = FALSE) +
  facet_wrap(~characterName, scales = 'free') +
  ggtitle('Total Words Per Main Character') +
  xlab('season') +
  ylab('Word Count')

# Character Mentions by Name - Excluding self references
tidyTranscripts %>% 
  filter(characterType == 'main') %>% 
  anti_join(stop_words) %>%
  mutate(word = ifelse(word == 'dad', 'martin', word)) %>% 
  count(character, 
        word, 
        sort = TRUE) %>%
  mutate(n = ifelse(tolower(character) == word, 0, n)) %>% 
  spread(character, 
         n, 
         fill = 0) %>%
  mutate(total = Daphne + Frasier + Martin + Niles + Roz) %>% 
  arrange(desc(total)) %>% 
  filter(grepl('^(martin|frasier|niles|roz|daphne)$', word))


# Character Mentions by Name - Excluding self references
tidyTranscripts %>% 
  filter(characterType == 'main') %>% 
  anti_join(stop_words) %>%
  mutate(word = ifelse(word == 'dad', 'martin', word)) %>% 
  count(character, 
        word, 
        sort = TRUE) %>%
  mutate(n = ifelse(tolower(character) == word, 0, n)) %>% 
  filter(grepl('^(martin|frasier|niles|roz|daphne)$', word)) %>% 
  ggplot(aes(word, n, fill = character)) +
  geom_bar(stat = 'identity') +
  facet_wrap(~character)