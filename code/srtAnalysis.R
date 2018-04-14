tidyFrasier <- subtitles %>% 
  unnest_tokens(word, text) %>% 
  anti_join(stop_words)

tidyFrasier %>% 
  count(word, sort = TRUE)

bing <- sentiments %>%
  filter(lexicon == "bing") %>%
  select(-score)

frasierSentiment <- tidyFrasier %>% 
  inner_join(bing) %>% 
  count(title, 
        index = as.integer(id) %/% 50, 
        sentiment) %>% 
  spread(sentiment, 
         n, 
         fill = 0) %>% 
  mutate(sentiment = positive - negative) %>%
  left_join(tidyFrasier[,c("title",
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

frasierSentiment %>% 
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
frasierSentiment %>% 
  select(dateTimeIn, sentiment) %>% 
  count(sentiment)

tidyFrasier %>% 
  filter(season == 7) %>% 
  arrange(timecodeIn) %>% 
  inner_join(bing) %>% 
  mutate(minute = ceiling_date(ymd_hms(dateTimeOut), unit = "minutes")) %>% 
  group_by(minute, season, episode) %>%
  count(sentiment) %>% 
  spread(sentiment, 
         n, 
         fill = 0) %>% 
  mutate(polarity = positive - negative) %>% 
  ggplot(aes(minute, polarity)) + 
  geom_smooth() +
  facet_wrap(~season, scales = "free_x")

frasierSentiment %>% 
  select(dateTimeIn, sentiment) %>% 
  count(sentiment)

tidyFrasier %>% 
  arrange(timecodeIn) %>% 
  inner_join(bing) %>% 
  mutate(minute = ceiling_date(ymd_hms(dateTimeOut), unit = "minutes")) %>% 
  group_by(minute, season, episode) %>%
  count(sentiment) %>% 
  spread(sentiment, 
         n, 
         fill = 0) %>% 
  mutate(polarity = positive - negative) %>% 
  ggplot(aes(minute, polarity)) + 
  geom_smooth() +
  facet_wrap(~season, scales = "free_x")

tidyFrasier %>% 
  arrange(timecodeIn) %>% 
  inner_join(bing) %>% 
  mutate(minute = ceiling_date(ymd_hms(dateTimeOut), unit = "minutes")) %>% 
  group_by(minute, season, episode) %>%
  count(sentiment) %>% 
  spread(sentiment, 
         n, 
         fill = 0) %>% 
  mutate(polarity = positive - negative) %>% 
  group_by(season, episode) %>% 
  summarize(polarity = median(polarity)) %>% 
  ggplot(aes(episode, polarity)) + 
  geom_bar(stat = 'identity') +
  facet_wrap(~season)
