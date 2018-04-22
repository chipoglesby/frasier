transcripts %>% 
  unnest_tokens(word, lines, to_lower = TRUE) %>% 
  anti_join(stop_words) -> tidyTranscripts


tidyTranscripts %>% 
  count(season, 
        episode, 
        character, 
        word, sort = TRUE) -> transcriptWordCount