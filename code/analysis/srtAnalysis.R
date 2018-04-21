## Tidy Text Analysis
# Tidy the subtitles
tidySubtitles <- subtitles %>% 
  unnest_tokens(word, text) %>% 
  anti_join(stop_words)

# Check out the top ten words, excluding main characters names
tidySubtitles %>%
  inner_join(get_sentiments('bing'), "word") %>% 
  filter(!grepl('frasier|roz|daphne|martin|niles|dad|crane|dr', word)) %>% 
  count(word, sentiment, sort = TRUE) %>% 
  top_n(10, n)

# Add tidy bing
bing <- sentiments %>%
  filter(lexicon == "bing") %>%
  select(-score)

# Add Sentiment to tidySubtitles
subtitleSentiment <- tidySubtitles %>% 
  inner_join(bing) %>% 
  count(title, 
        index = as.integer(id) %/% 50, 
        sentiment) %>% 
  spread(sentiment, 
         n, 
         fill = 0) %>% 
  mutate(sentiment = positive - negative) %>%
  left_join(tidySubtitles[,c("title",
                           "season",
                           "episode")] %>% 
              distinct()) %>% 
  arrange(season,
          episode) %>% 
  mutate(episode_name = paste(season,
                              episode,
                              "-",
                              title),
         season = factor(season, 
                         labels = 
                           c("Season 1", 
                             "Season 2", 
                             "Season 3",
                             "Season 4", 
                             "Season 5", 
                             "Season 6",
                             "Season 7", 
                             "Season 8", 
                             "Season 9",
                             "Season 10", 
                             "Season 11"))) %>% 
  select(title, season, everything(), -episode)


## Sentence Analysis
# Prepare the dataframe
subtitleSentiment <- subtitles %>%
  get_sentences() %$%
  sentiment_by(text, list(season,
                          episode,
                          dateTimeOut)) %>% 
  arrange(dateTimeOut)


# Top References containing God
God <- subtitles %>% 
  filter(grepl('god', tolower(text))) %>% 
  count(text, sort = TRUE) %>% 
  top_n(5, n)