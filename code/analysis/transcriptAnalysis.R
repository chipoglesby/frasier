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

## In progress: Most unique words:
# transcriptWordCount %>% 
#   select(-n) %>% 
#   count(character, word, sort = TRUE) %>%
#   group_by(character) %>% 
#   mutate(total = sum(n),
#          nTotal = n/total) %>% 
#   arrange(desc(nTotal)) %>% 
#   bind_tf_idf(word, character, n) %>% 
#   select(-total) %>%
#   arrange(desc(tf_idf)) %>% 
#   ungroup() %>% 
#   mutate(word = factor(word, 
#                        levels = rev(unique(word)))) -> temp
# 
# temp %>% 
#   group_by(character) %>% 
#   summarize(test = n()) %>% 
#   ungroup() %>% 
#   mutate(test2 = sum(test)) %>% 
#   mutate(partTwo = test/test2) -> temp2
# 
# temp %>% 
#   group_by(word) %>% 
#   mutate(count = n(), partOne = square/count) %>% 
#   ungroup() %>% 
#   inner_join(temp2) %>% 
#   select(-test, -test2) %>% 
#   mutate(final = partOne * partTwo) %>% 
#   select(character, word, final) %>% 
#   arrange(character, final) -> test