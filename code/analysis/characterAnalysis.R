# devtools::install_github("trinker/sentimentr")
library(sentimentr)
library(magrittr)
library(tidyverse)

sentenceSentiment <- lines %>%
  get_sentences() %$%
  sentiment_by(lines, list(season, 
                           episode, 
                           character, 
                           gender, 
                           characterType)) %>% 
  arrange(desc(word_count))

sentenceSentiment %>% 
  filter(grepl('frasier|daphne|roz|niles|martin|bulldog', tolower(character))) %>%
  group_by(season, character) %>% 
  summarize(ave_sentiment = median(ave_sentiment)) %>% 
  ggplot(aes(season, ave_sentiment, color = character)) +
  geom_line(size = .75, show.legend = FALSE) +
  scale_x_continuous(breaks = c(1:11)) +
  facet_wrap(~character, scales = "free") +
  xlab("Season") +
  ylab('Median Sentiment') +
  ggtitle('Median Sentence Sentiment Per Season of Main Characters')

sentenceSentiment %>% 
  filter(grepl('frasier|daphne|roz|niles|martin|bulldog', tolower(character))) %>%
  group_by(season, character) %>% 
  summarize(ave_sentiment = median(ave_sentiment)) %>% 
  spread(character, ave_sentiment, fill = 0) %>% 
  knitr::kable()