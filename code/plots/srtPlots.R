# Plot for Sentiment of Episodes by minute:
tidySubtitles %>% 
  # filter(season == 1, episode == 1) %>%
  filter(season == 1) %>%
  arrange(timecodeIn) %>% 
  inner_join(bing) %>% 
  mutate(minute = ceiling_date(ymd_hms(dateTimeOut), unit = "minutes"),
         episode = as.factor(episode),
         season = as.factor(season)) %>% 
  group_by(minute, season, episode) %>%
  count(sentiment) %>% 
  spread(sentiment, 
         n, 
         fill = 0) %>% 
  mutate(sentiment = positive - negative) %>% 
  group_by(episode, minute) %>% 
  summarize(sentiment = mean(sentiment)) %>% 
  ggplot(aes(minute, sentiment, color = episode)) + 
  geom_line(size = .75, show.legend = FALSE) +
  facet_wrap(~episode, scales = 'free') +
  xlab('Minute') +
  ylab('Sentiment') +
  ggtitle('Sentiment of words in Frasier: Season One, by Episode & Minute')

# Minute Sentiment for S1E1
tidySubtitles %>% 
  filter(season == 1, episode == 1) %>% 
  arrange(timecodeIn) %>% 
  inner_join(bing) %>% 
  mutate(minute = ceiling_date(ymd_hms(dateTimeOut), unit = "minutes"),
         episode = as.factor(episode),
         season = as.factor(season)) %>% 
  group_by(minute, season, episode) %>%
  count(sentiment) %>% 
  spread(sentiment, 
         n, 
         fill = 0) %>% 
  mutate(sentiment = positive - negative) %>% 
  group_by(episode, minute) %>% 
  summarize(sentiment = mean(sentiment)) %>% 
  ggplot(aes(minute, sentiment)) + 
  geom_line(color = '#5C220E',
            size = .95, 
            show.legend = FALSE) +
  scale_x_datetime(date_breaks = "1 min",
                   labels = date_format("%M")) +
  xlab('Minute') +
  ylab('Sentiment') +
  ggtitle('Sentiment of words in Frasier: S1E1, by Minute')

# Sentiment in Frasier
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

# Sentiment By Season and Episode
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


## Sentence Plots

subtitleSentiment %>% 
  filter(season == 1, episode == 1) %>% 
  ggplot(aes(dateTimeOut, 
             ave_sentiment)) +
  geom_smooth() +
  xlab('Timecode') +
  ylab('Sentiment') +
  ggtitle('Time Series Sentiment of Frasier: S1, E1')

# Plot an entire season
subtitleSentiment %>% 
  filter(season == 8) %>% 
  ggplot(aes(dateTimeOut, 
             ave_sentiment)) +
  geom_smooth() +
  xlab('Timecode') +
  ylab('Sentiment') +
  ggtitle('Time Series Sentiment of Frasier By Episode: Season Eight') +
  facet_wrap(~episode, scales = 'free')

# Top 10 words of each season
tidySubtitles %>% 
  mutate(season = as.factor(season)) %>%
  filter(!grepl('frasier|roz|daphne|martin|niles|dad|crane|dr', word)) %>% 
  group_by(season) %>%
  count(word, 
        sort = TRUE) %>%
  top_n(10, n) %>%
  ggplot(aes(reorder(word,n), 
             n, 
             fill = season)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~season, scales = "free_y") +
  labs(x = NULL) +
  guides(fill = FALSE)


## TF-IDF

# Skew
tidySubtitles %>% 
  count(season, word, sort = TRUE) %>%
  group_by(season) %>% 
  mutate(total = sum(n)) %>% 
  ggplot(aes(n/total, fill = season)) +
  geom_histogram(alpha = 0.8, 
                 show.legend = FALSE,
                 bins = 15) +
  xlim(0, 0.001) +
  labs(title = "Term Frequency Distribution in Frasier's Seasons",
       y = "Count") +
  facet_wrap(~season, scales = "free_y") +
  theme_minimal(base_size = 13) +
  scale_fill_viridis(end = 0.85, discrete = FALSE) +
  theme(strip.text = element_text(hjust = 0)) +
  theme(strip.text = element_text(face = "italic"))

# Least Common Words overall
tfIDF %>% 
  ggplot(aes(tf_idf, word, fill = season, alpha = tf_idf)) +
  geom_barh(stat = "identity") +
  labs(title = "Highest tf-idf words in Frasier's Seasons",
       y = NULL, x = "tf-idf") +
  theme_minimal(base_size = 13) +
  scale_alpha_continuous(range = c(0.6, 1), 
                         guide = FALSE) +
  scale_x_continuous(expand = c(0, 0)) +
  scale_fill_viridis(end = 0.85, 
                     discrete = FALSE) +
  theme(legend.title = element_blank()) +
  theme(legend.justification = c(1, 0),
        legend.position = c(1, 0))


# Least Common Words by Season
tfIDF %>% 
  group_by(season) %>% 
  top_n(15) %>% 
  ungroup() %>% 
  ggplot(aes(tf_idf, word, fill = season, alpha = tf_idf)) +
  geom_barh(stat = "identity", show.legend = FALSE) +
  labs(title = "Highest tf-idf words in Frasiers' Seasons",
       y = NULL, x = "tf-idf") +
  facet_wrap(~season,
             scales = "free") +
  theme_minimal(base_size = 13) +
  scale_alpha_continuous(range = c(0.6, 1)) +
  scale_x_continuous(expand = c(0,0)) +
  scale_fill_viridis(end = 0.85, 
                     discrete = FALSE) +
  theme(strip.text = element_text(hjust = 0)) +
  theme(strip.text = element_text(face = "italic"))