lines %>%
  mutate(season = as.factor(season)) %>%
  group_by(episode, 
           season, 
           originalAirDate) %>% 
  summarize(imdbRatings = mean(imdbRatings)) %>% 
  ggplot(aes(episode, 
             imdbRatings, 
             color = season)) +
  geom_line(size = .95) +
  ggtitle('IMDB Ratings For Episodes by Season')+
  xlab('Episode') +
  ylab('IMDB Rating') +
  facet_wrap(~season, scales = 'free')
  
lines %>%
  mutate(season = as.factor(season)) %>%
  group_by(episode, 
           season, 
           originalAirDate) %>% 
  summarize(imdbVotes = mean(imdbVotes)) %>% 
  ggplot(aes(episode, 
             imdbVotes, 
             color = season)) +
  geom_line(size = .95) +
  ggtitle('IMDB Votes For Episodes by Season') +
  xlab('Episode') +
  ylab('IMDB Votes') +
  facet_wrap(~season, scales = 'free')
