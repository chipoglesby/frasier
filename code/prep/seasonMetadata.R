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
 mutate(season = 3) -> seasonThree

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
  rbind(c(19,
    "Three Dates and a Break Up",
    "Jeff Melman",
    "Rob Greenberg",
    "April 29, 1997 (1997-04-29)",
    "15"),
    c(20,
      "Three Dates and a Break Up",
      "Jeff Melman",
      "Rob Greenberg",
      "April 29, 1997 (1997-04-29)",
      "15")) %>% 
  mutate(season = 4) -> seasonFour

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
  mutate(season = 5) -> seasonFive

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
  rbind(c("23",
          "Shutout in Seattle",
          "Pamela Fryman",
          "David Isaacs",
          "May 20, 1999 (1999-05-20)",
          "27.2"),
        c("24",
          "Shutout in Seattle",
          "Pamela Fryman",
          "David Isaacs",
          "May 20, 1999 (1999-05-20)",
          "27.2")) %>%
  mutate(season = 6) -> seasonSix

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
         viewershipInMillions = Viewers..millions..65.) %>% 
  mutate(season = 7) -> seasonSeven

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
  rbind(c("1",
          "And the Dish Ran Away with the Spoon",  
          "Pamela Fryman",
          "David Angell & Peter Casey",
          "October 24, 2000 (2000-10-24)",
          "28.6"),
        c("2",
          "And the Dish Ran Away with the Spoon",  
          "Pamela Fryman",
          "David Angell & Peter Casey",
          "October 24, 2000 (2000-10-24)",
          "28.6")) %>% 
  mutate(season = 8) -> seasonEight

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
  rbind(c("1",
          "Don Juan in Hell",  
          "Kelsey Grammer",
          "Sam Johnson & Chris Marcil",
          "September 25, 2001 (2001-09-25)",
          "19.6"),
        c("2",
          "Don Juan in Hell",  
          "Kelsey Grammer",
          "Lori Kirkland",
          "September 25, 2001 (2001-09-25)",
          "19.6")) %>% 
  mutate(season = 9) -> seasonNine

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
  mutate(season = 10) -> seasonTen

url %>% 
  read_html() %>% 
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[12]') %>% 
  html_table() %>% 
  as.data.frame() %>% 
  select(-No..in.series) %>%
  rename(episode = No..in.season,
         title = Title,
         directedBy = Directed.by,
         writtenBy = Written.by,
         originalAirDate = Original.air.date,
         viewershipInMillions =  Millions..millions..70.) %>% 
  rbind(c("23",
          "Goodnight, Seattle",  
          "David Lee",
          "Christopher Lloyd & Joe Keenan",
          "May 13, 2004 (2004-05-13)",
          "33.7"),
        c("24",
          "Goodnight, Seattle",  
          "David Lee",
          "Christopher Lloyd & Joe Keenan",
          "May 13, 2004 (2004-05-13)",
          "33.7")) %>% 
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
  data.frame(stringsAsFactors = FALSE) -> episodeList

imdbMetadata = NULL
for (i in 1:length(episodeList$.)) {
  episodeList$.[i] %>% 
    read_html() %>% 
    html_nodes('div.ipl-rating-star span.ipl-rating-star__rating') %>% 
    html_text() %>% 
    unlist() %>% 
    data.frame() %>% 
    rename(imdbRatings = '.') %>% 
    mutate(imdbRatings = as.character(imdbRatings)) %>% 
    filter(grepl("\\.", imdbRatings)) %>% 
    mutate(imdbRatings = as.numeric(imdbRatings)) -> imdbRatings
  
  episodeList$.[i] %>% 
    read_html() %>% 
    html_nodes('span.ipl-rating-star__total-votes') %>% 
    html_text() %>% 
    unlist() %>% 
    data.frame() %>% 
    rename(imdbVotes = '.') %>% 
    mutate(imdbVotes = as.integer(gsub("\\(|\\)",
                                       "", 
                                       as.character(imdbVotes)))) -> imdbVotes
  
  episode = NULL
  for (n in 1:nrow(imdbRatings)) {
    rbind(n, episode) -> episode
    data.frame(episode) %>% 
      arrange(episode) -> episodeCount
  }
  
  imdb <- 
    data.frame(imdbVotes, imdbRatings, episode) %>% 
    mutate(season = i)
  rbind(imdb, imdbMetadata) -> imdbMetadata
}

rm(imdb)
rm(episode)
rm(i)
rm(n)
rm(imdbRatings)
rm(imdbVotes)

seasons %<>% 
  inner_join(imdbMetadata)