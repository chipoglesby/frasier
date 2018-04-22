c("http://www.imdb.com/title/tt0106004/episodes?season=1",
  "http://www.imdb.com/title/tt0106004/episodes?season=2",
  "http://www.imdb.com/title/tt0106004/episodes?season=3",
  "http://www.imdb.com/title/tt0106004/episodes?season=4",
  "http://www.imdb.com/title/tt0106004/episodes?season=5",
  "http://www.imdb.com/title/tt0106004/episodes?season=6",
  "http://www.imdb.com/title/tt0106004/episodes?season=7",
  "http://www.imdb.com/title/tt0106004/episodes?season=8",
  "http://www.imdb.com/title/tt0106004/episodes?season=9",
  "http://www.imdb.com/title/tt0106004/episodes?season=10",
  "http://www.imdb.com/title/tt0106004/episodes?season=11") %>% 
  data.frame(stringsAsFactors = FALSE) -> seasonList

fullCastList = NULL
for (a in 1:length(seasonList$.)) {
  seasonList$.[a] %>% 
    read_html() %>% 
    html_nodes('.list.detail.eplist strong a') %>% 
    html_attr('href') %>% 
    data.frame() -> episodeList
  for(b in 1:length(episodeList$.)){
    paste0("http://www.imdb.com", episodeList$.[b]) %>% 
      read_html() %>% 
      html_nodes(xpath = '//*[@id="titleCast"]/table') %>%
      html_table() %>% 
      as.data.frame() %>% 
      select(-X1, -X3) %>% 
      rename(actorName = X2,
             characterName = X4) %>% 
      mutate(episode = b,
             season = a) %>% 
      rbind(.,fullCastList) -> fullCastList
  }
}

fullCastList %<>% 
  filter(!grepl('episode|rest of', tolower(characterName))) %>%
  count(characterName) %>% 
  inner_join(fullCastList) %>%
  mutate(actorName = trimws(actorName),
         characterName = trimws(
           gsub('/ ...|#|Dr.|\\n|Guest Caller - |\\(voice\\)|\\s{2,}|\\(.*\\)', '',
                sapply(strsplit(characterName, '\\d',"-"), `[`, 1))),
         characterType = as.factor(
           ifelse(n < 4, "other",
                  ifelse(n > 100, "main", "recurring"))),
         firstName = sapply(strsplit(characterName, ' '), `[`, 1)) %>% 
  select(-n) %>% 
  arrange(season, episode) 

fullCastList %>% 
  write_csv('data/csv/clean/fullCastList.csv') %>% 
  saveRDS(., file = 'data/rds/fullCastList.rds')

rm(a)
rm(b)