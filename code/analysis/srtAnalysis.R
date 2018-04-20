tidySubtitles <- subtitles %>% 
  unnest_tokens(word, text) %>% 
  anti_join(stop_words)

tidySubtitles %>%
  inner_join(get_sentiments('bing'), "word") %>% 
  filter(!grepl('frasier|roz|daphne|martin|niles|dad|crane|dr', word)) %>% 
  count(word, sentiment, sort = TRUE) %>% 
  top_n(10, n) %>% 
  knitr::kable()

bing <- sentiments %>%
  filter(lexicon == "bing") %>%
  select(-score)

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

subtitleSentiment %>% 
  ggplot(aes(index, sentiment, fill = season)) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  facet_wrap(~season, nrow = 3, scales = "free_x", dir = "v") +
  theme_minimal(base_size = 13) +
  labs(title = "Sentiment in Frasier",
       y = "Sentiment") +
  scale_fill_viridis(end = 0.75, discrete = TRUE) +
  scale_x_discrete(expand = c(0.02,0)) +
  theme(strip.text = element_text(hjust = 0)) +
  theme(strip.text = element_text(face = "italic")) +
  theme(axis.title.x = element_blank()) +
  theme(axis.ticks.x = element_blank()) +
  theme(axis.text.x = element_blank())

tidySubtitles %>% 
  arrange(timecodeIn) %>% 
  inner_join(bing) %>% 
  mutate(minute = ceiling_date(ymd_hms(dateTimeOut), unit = "minutes")) %>% 
  group_by(minute, season, episode) %>%
  count(sentiment) %>% 
  spread(sentiment, 
         n, 
         fill = 0) %>% 
  mutate(sentiment = positive - negative) %>% 
  group_by(season, episode) %>% 
  summarize(sentiment = mean(sentiment)) %>% 
  ggplot(aes(episode, sentiment)) + 
  geom_bar(stat = 'identity') +
  facet_wrap(~season) +
  xlab('Episode') +
  ylab('Mean of Sentiment') +
  ggtitle('Sentiment of words in Frasier, by Season & Episode')


## Sentence Analysis
# Prepare the dataframe
subtitleSentiment <- subtitles %>%
  get_sentences() %$%
  sentiment_by(text, list(season,
                          episode,
                          dateTimeOut)) %>% 
  arrange(dateTimeOut)

# Plot the data, specific example
subtitleSentiment %>% 
  filter(season == 4, episode == 7) %>% 
  ggplot(aes(dateTimeOut, 
             ave_sentiment)) +
  geom_smooth() +
  xlab('Timecode') +
  ylab('Sentiment') +
  ggtitle('Time Series Sentiment of Frasier, Season 4, Episode 7')


# Plot an entire season
subtitleSentiment %>% 
  filter(season == 8) %>% 
  ggplot(aes(dateTimeOut, 
             ave_sentiment)) +
  geom_smooth() +
  xlab('Timecode') +
  ylab('Sentiment') +
  ggtitle('Time Series Sentiment of Frasier By Episode') +
  facet_wrap(~episode, scales = 'free')
