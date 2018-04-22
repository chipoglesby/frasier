transcripts %>% 
  unnest_tokens(word, lines, to_lower = TRUE) %>% 
  anti_join(stop_words) -> tidyTranscripts


tidyTranscripts %>% 
  count(season, 
        episode, 
        character, 
        word, sort = TRUE) -> transcriptWordCount

transcriptWordCount %>% 
  select(-n) %>% 
  count(character, word, sort = TRUE) %>%
  group_by(character) %>% 
  mutate(total = sum(n),
         nTotal = n/total) %>% 
  arrange(desc(nTotal)) %>% 
  bind_tf_idf(word, character, n) %>% 
  select(-total) %>%
  arrange(desc(tf_idf)) %>% 
  ungroup() %>% 
  mutate(word = factor(word, 
                       levels = rev(unique(word)))) -> temp

temp2 <- temp %>% 
  group_by(character) %>% 
  summarize(test = n()) %>% 
  ungroup() %>% 
  mutate(test2 = sum(test)) %>% 
  mutate(partTwo = test/test2)

test <- temp %>% 
  group_by(word) %>% 
  mutate(count = n(), partOne = square/count) %>% 
  ungroup() %>% 
  inner_join(temp2) %>% 
  select(-test, -test2) %>% 
  mutate(final = partOne * partTwo) %>% 
  select(character, word, final) %>% 
  arrange(character, final)

