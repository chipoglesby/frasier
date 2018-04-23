# Box plot of line counts men vs women by season
transcripts %>%
  filter(gender != 'other') %>% 
  mutate(season = as.factor(season),
         episode = as.factor(episode)) %>% 
  group_by(gender, 
           season, 
           episode) %>%
  summarize(lineCount = n()) %>% 
  ggplot(aes(gender, 
             lineCount,
             fill = gender)) +
  geom_boxplot() +
  facet_wrap(~season, 
             scales = 'free') +
  ggtitle('Boxplot: Lines Count Men vs Women') +
  xlab('Gender') +
  ylab('Line Count')

# Box plots of line counts men vs women by Character Type
transcripts %>%
  filter(gender != 'other') %>% 
  mutate(season = as.factor(season),
         episode = as.factor(episode)) %>% 
  group_by(gender, 
           season, 
           episode,
           characterType) %>%
  summarize(lineCount = n()) %>% 
  ggplot(aes(gender, 
             lineCount,
             fill = gender)) +
  geom_boxplot() +
  ggtitle('Boxplot: Lines Count Men vs Women') +
  xlab('Gender') +
  ylab('Line Count') +
  facet_wrap(~characterType, scales = 'free')

transcripts %>%
  filter(characterType == 'main') %>% 
  mutate(season = as.factor(season),
         episode = as.factor(episode)) %>% 
  group_by(character, 
           season, 
           episode) %>%
  summarize(lineCount = n()) %>% 
  ggplot(aes(character, 
             lineCount,
             fill = character)) +
  geom_boxplot() +
  facet_wrap(~season, 
             scales = 'free') +
  ggtitle('Boxplot: Lines Count of Main Characters') +
  xlab('Character') +
  ylab('Line Count')

transcripts %>%
  filter(characterType == 'main') %>% 
  group_by(character) %>%
  summarize(lineCount = n(),
            total = sum(lineCount),
            lineShare = sum(lineCount/total)) %>%
  mutate(total = sum(lineCount),
         lineShare = lineCount/total) %>% 
  ggplot(aes(character, 
             lineShare,
             fill = character)) +
  geom_bar(stat = 'identity') +
  ggtitle('Line Share of Main Characters') +
  xlab('Character') +
  ylab('Line Share')

transcripts %>%
  group_by(characterType) %>%
  summarize(lineCount = n(),
            total = sum(lineCount),
            lineShare = sum(lineCount/total)) %>%
  mutate(total = sum(lineCount),
         lineShare = lineCount/total) %>% 
  ggplot(aes(characterType, 
             lineShare,
             fill = characterType)) +
  geom_bar(stat = 'identity') +
  ggtitle('Line Share of Character Types') +
  xlab('Character Type') +
  ylab('Line Share')

transcripts %>%
  group_by(gender) %>%
  summarize(lineCount = n(),
            total = sum(lineCount),
            lineShare = sum(lineCount/total)) %>%
  mutate(total = sum(lineCount),
         lineShare = lineCount/total) %>% 
  ggplot(aes(gender, 
             lineShare,
             fill = gender)) +
  geom_bar(stat = 'identity') +
  ggtitle('Line Share of Gender Types') +
  xlab('Gender') +
  ylab('Line Share')


transcripts %>%
  filter(characterType == 'main') %>% 
  group_by(episodeCount,
           characterName) %>% 
  summarize(lines = n()) %>% 
  ggplot(aes(episodeCount,
             lines,
             color = characterName)) +
  geom_smooth(se = FALSE) +
  xlab('Episode') +
  ylab('Lines') +
  ggtitle('Lines Per Main Character')

transcripts %>%
  group_by(episodeCount,
           characterType) %>% 
  summarize(lines = n()) %>% 
  ggplot(aes(episodeCount,
             lines,
             color = characterType)) +
  geom_smooth(se = FALSE) +
  xlab('Episode') +
  ylab('Lines') +
  ggtitle('Lines Per Character Type')