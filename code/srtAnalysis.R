subtitlesSummary <- subtitles %>% 
  group_by(season, episode) %>% 
  summarize(n = n(),
            talkTime = as.integer(round(sum(talkTime)/60, 2)),
            minTime = min(timecodeIn),
            maxTime = max(timecodeOut))

subtitlesSummary %>% 
  arrange(season, talkTime) %>% 
  ggplot(aes(episode, n)) +
  geom_bar(stat = "identity") +
  facet_wrap(~season, scales = "free")

subtitles %>%
  filter(season == 1, episode == 1) %>% 
  count(psuedoTimeIn) %>% 
  ggplot(aes(psuedoTimeIn, n)) +
  geom_line()