library("rvest")

url <- "https://en.wikipedia.org/wiki/List_of_Frasier_episodes"

url %>% 
  read_html() %>% 
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[2]') %>% 
  html_table() %>% 
  as.data.frame() %>%
  select(-No..in.series) %>% 
  rename(episode = No..in.season,
         title = Title,
         directedBy = Directed.by,
         writtenBy = Written.by,
         originalAirDate = Original.air.date,
         viewershipInMillions = U.S..viewers..million...3..4..5..6.) %>% 
  mutate(season = 1) -> seasonOne

url %>% 
  read_html() %>% 
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[3]') %>% 
  html_table() %>% 
  as.data.frame() %>% 
  select(-No..in.series) %>% 
  rename(episode = No..in.season,
         title = Title,
         directedBy = Directed.by,
         writtenBy = Written.by,
         originalAirDate = Original.air.date,
         viewershipInMillions = U.S..viewers..million.) %>% 
mutate(season = 2) -> seasonTwo

url %>% 
  read_html() %>% 
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[4]') %>% 
  html_table() %>% 
  as.data.frame() %>% 
  select(-No..in.series) %>% 
  rename(episode = No..in.season,
         title = Title,
         directedBy = Directed.by,
         writtenBy = Written.by,
         originalAirDate = Original.air.date,
         viewershipInMillions = U.S..viewers..million.) %>% 
 mutate(season = 3)-> seasonThree

url %>% 
  read_html() %>% 
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[5]') %>% 
  html_table() %>% 
  as.data.frame() %>% 
  select(-No..in.series) %>%
  rename(episode = No..in.season,
         title = Title,
         directedBy = Directed.by,
         writtenBy = Written.by,
         originalAirDate = Original.air.date,
         viewershipInMillions = U.S..viewers..million.) %>% 
  mutate(season = 4) -> seasonFour

url %>% 
  read_html() %>% 
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[5]') %>% 
  html_table() %>% 
  as.data.frame() %>% 
  select(-No..in.series) %>%
  rename(episode = No..in.season,
         title = Title,
         directedBy = Directed.by,
         writtenBy = Written.by,
         originalAirDate = Original.air.date,
         viewershipInMillions = U.S..viewers..million.) %>% 
  mutate(season = 5) -> seasonFive

url %>% 
  read_html() %>% 
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[6]') %>% 
  html_table() %>% 
  as.data.frame() %>% 
  select(-No..in.series) %>%
  rename(episode = No..in.season,
         title = Title,
         directedBy = Directed.by,
         writtenBy = Written.by,
         originalAirDate = Original.air.date,
         viewershipInMillions = U.S..viewers..million.) %>% 
  mutate(season = 6) -> seasonSix

url %>% 
  read_html() %>% 
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[7]') %>% 
  html_table() %>% 
  as.data.frame() %>% 
  select(-No..in.series) %>%
  rename(episode = No..in.season,
         title = Title,
         directedBy = Directed.by,
         writtenBy = Written.by,
         originalAirDate = Original.air.date,
         viewershipInMillions = U.S..viewers..in.millions..64.) %>% 
  mutate(season = 7) -> seasonSeven

url %>% 
  read_html() %>% 
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[8]') %>% 
  html_table() %>% 
  as.data.frame() %>% 
  select(-No..in.series) %>%
  rename(episode = No..in.season,
         title = Title,
         directedBy = Directed.by,
         writtenBy = Written.by,
         originalAirDate = Original.air.date,
         viewershipInMillions =  Viewers..millions..65.) %>% 
  mutate(season = 8) -> seasonEight

url %>% 
  read_html() %>% 
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[9]') %>% 
  html_table() %>% 
  as.data.frame() %>%
  select(-No..in.series) %>%
  rename(episode = No..in.season,
         title = Title,
         directedBy = Directed.by,
         writtenBy = Written.by,
         originalAirDate = Original.air.date,
         viewershipInMillions =  Viewers..millions..66.) %>% 
  mutate(season = 9) -> seasonNine

url %>% 
  read_html() %>% 
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[10]') %>% 
  html_table() %>% 
  as.data.frame() %>% 
  select(-No..in.series) %>%
  rename(episode = No..in.season,
         title = Title,
         directedBy = Directed.by,
         writtenBy = Written.by,
         originalAirDate = Original.air.date,
         viewershipInMillions =  Viewers..millions..67.) %>% 
  mutate(season = 10) -> seasonTen

url %>% 
  read_html() %>% 
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[11]') %>% 
  html_table() %>% 
  as.data.frame() %>% 
  select(-No..in.series) %>%
  rename(episode = No..in.season,
         title = Title,
         directedBy = Directed.by,
         writtenBy = Written.by,
         originalAirDate = Original.air.date,
         viewershipInMillions =  Viewers..millions..69.) %>% 
  mutate(season = 11) -> seasonEleven

rbind(seasonOne,
      seasonTwo,
      seasonThree,
      seasonFour,
      seasonFive,
      seasonSix,
      seasonSeven,
      seasonEight,
      seasonNine,
      seasonTen,
      seasonEleven) %>% 
  mutate(title = gsub('"', '', title),
         originalAirDate = 
           date(str_extract(originalAirDate,
                            '\\d{4}-\\d{2}-\\d{2}')),
         viewershipInMillions = as.integer(gsub('\\[\\d{1,}\\]', '', viewershipInMillions)),
         episode = as.integer(episode)) -> seasons

rm(seasonOne)
rm(seasonTwo)
rm(seasonThree)
rm(seasonFour)
rm(seasonFive)
rm(seasonSix)
rm(seasonSeven)
rm(seasonEight)
rm(seasonNine)
rm(seasonTen)
rm(seasonEleven)
rm(url)