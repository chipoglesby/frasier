# Create Tidy Transcripts
transcripts %>% 
  unnest_tokens(word, 
                lines,
                to_lower = TRUE, 
                drop = FALSE) -> tidyTranscripts

tidyTranscripts %>% 
  write_csv('data/csv/clean/tidyTranscripts.csv') %>% 
  saveRDS(., 'data/rds/tidyTranscripts.csv')

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