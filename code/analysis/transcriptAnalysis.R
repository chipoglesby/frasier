# Create Tidy Transcripts
transcripts %>%
  unnest_tokens(word, 
                lines,
                to_lower = TRUE, 
                drop = FALSE) -> tidyTranscripts

tidyTranscripts %>% 
  write_csv('data/csv/clean/tidyTranscripts.csv') %>% 
  saveRDS(., 'data/rds/tidyTranscripts.csv')

## Words

# Transcript Word Count
tidyTranscripts %>% 
  count(season, 
        episode, 
        episodeCount,
        character,
        characterType,
        gender,
        word) -> transcriptWordCount

# Mean Letter Per Word
transcripts %>% 
  filter(characterType == 'main') %>% 
  unnest_tokens(word, lines) %>% 
  group_by(characterName, word) %>%
  mutate(lpw = nchar(word)) %>% 
  select(characterName, word, lpw) %>% 
  group_by(characterName) %>% 
  summarize(meanLetterPerWord = mean(lpw)) %>% 
  arrange(desc(meanLetterPerWord)) -> meanLetterPerWord

# Total Line Count Per Episode
transcripts %>% 
  group_by(characterName,
           episodeCount,
           characterType) %>% 
  summarize(lines = n()) %>% 
  arrange(desc(lines)) %>% 
  ungroup() -> lineCount

# Line Count Percent of Total Share
lineCount %>% 
  group_by(characterName,
           characterType) %>% 
  summarize(count = sum(lines)) %>% 
  arrange(desc(count)) %>% 
  ungroup() %>% 
  mutate(percentTotal = count/sum(count)*100) -> characterTotals

# Word Count Per Episode
transcriptWordCount %>% 
  filter(characterType == 'main') %>% 
  anti_join(stop_words) %>% 
  count(character, episodeCount, sort = TRUE) -> wordCountPerEpisode

# Who spoke the most distinct words?
tidyTranscripts %>% 
  anti_join(stop_words) %>% 
  distinct(character, characterType, word) %>% 
  count(character, characterType, sort = TRUE) %>% 
  mutate(percentTotal = n/sum(n)*100) %>% 
  filter(characterType == 'main') %>% 
  select(-characterType) -> individualUniqueWords


## Sentiment Analysis
tidyTranscripts %>% 
  filter(characterType == 'main') %>% 
  anti_join(stop_words) %>% 
  inner_join(get_sentiments('bing'), "word") %>%
  count(characterName, 
        episodeCount, 
        sentiment, 
        sort = TRUE) %>%
  mutate(sentiment = as.factor(sentiment)) %>%
  spread(sentiment,
         n,
         fill = 0) %>% 
  group_by(characterName, episodeCount) %>% 
  summarize(sentiment = positive - negative) -> mainCharacterSentiment

mainCharacterSentiment$episodeCount[
  mainCharacterSentiment$sentiment == 
    min(mainCharacterSentiment$sentiment, 
        mainCharacterSentiment$characterName == 'Frasier Crane')][1] -> episodeLow

unique(transcripts$title[transcripts$episodeCount == episodeLow]) -> episodeLowName

mainCharacterSentiment$episodeCount[
  mainCharacterSentiment$sentiment == 
    max(mainCharacterSentiment$sentiment, 
        mainCharacterSentiment$characterName == 'Frasier Crane')][1] -> episodeHigh

unique(
  transcripts$title[
    transcripts$episodeCount == episodeHigh]) -> episodeHighName

# Main Character's Distinguishing Words
tidyTranscripts %>% 
  filter(characterType == 'main') %>% 
  anti_join(stop_words) %>%
  count(character, 
        word, 
        sort = TRUE) %>% 
  group_by(word) %>%
  mutate(totalTimesSaid = sum(n)) %>%
  ungroup() %>% 
  mutate(percentage = n/totalTimesSaid * n) %>% 
  group_by(character) %>%
  mutate(characterSpoken = n()) %>% 
  ungroup() %>% 
  mutate(anyoneSpoken = n(),
         uniquenessOfWord = percentage * anyoneSpoken/characterSpoken) %>% 
  group_by(word) %>% 
  top_n(1, uniquenessOfWord) %>% 
  ungroup() %>% 
  group_by(character) %>% 
  top_n(5, uniquenessOfWord) %>% 
  ungroup() %>% 
  select(character, word, uniquenessOfWord) %>% 
  arrange(character, desc(uniquenessOfWord)) -> distinguishingWords

# Who mentions who?
tidyTranscripts %>% 
  filter(characterType == 'main') %>% 
  anti_join(stop_words) %>%
  mutate(word = ifelse(word == 'dad', 'martin', ifelse(word == 'fras', 'frasier', word)),
         word = ifelse(word == tolower(character), NA, word)) %>%
  filter(grepl('^(niles|dad|martin|fras|roz|daphne|frasier)$', word)) %>% 
  count(character,
        word, 
        sort = TRUE) -> mostMentionedMainCharacter

bing <- sentiments %>%
  filter(lexicon == "bing") %>%
  select(-score)