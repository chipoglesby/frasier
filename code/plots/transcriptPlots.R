lines %>%
  mutate(lineCount = n()) %>% 
  

lines %>%
  filter(!is.na(gender)) %>% 
  mutate(season = as.factor(season),
         episode = as.factor(episode)) %>% 
  group_by(gender, 
           season, 
           episode) %>%
  summarize(lineCount = n()) %>% 
  ggplot(aes(gender, lineCount)) +
  geom_boxplot() +
  facet_wrap(~season, scales = 'free') +
  ggtitle('Boxplot: Lines Count Men vs Women') +
  xlab('Gender') +
  ylab('Line Count')


lines %>%
  filter(!is.na(gender)) %>% 
  mutate(season = as.factor(season),
         episode = as.factor(episode)) %>% 
  group_by(gender, 
           season, 
           episode,
           characterType) %>%
  summarize(lineCount = n()) %>% 
  ggplot(aes(gender, lineCount)) +
  geom_boxplot() +
  ggtitle('Boxplot: Lines Count Men vs Women') +
  xlab('Gender') +
  ylab('Line Count') +
  facet_wrap(~characterType, scales = 'free')