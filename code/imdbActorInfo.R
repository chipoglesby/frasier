library('rvest')

url <- 'http://www.imdb.com/title/tt0106004/fullcredits/?ref_=tt_ov_st_sm'

mainCharacter <- "^frasier|^daphne moon$|^roz doyle$|^niles crane$|^martin crane$|^bulldog briscoe$|^eddie$"
reccurringCharacter <- "bebe|^gil|noel shempsky|donny douglas|^kenny$|gertrude|simon|kirby|alice may doyle"

url %>% 
  read_html() %>% 
  html_nodes(xpath = "//*[@id='fullcredits_content']/table[3]") %>% 
  html_table() %>% 
  as.data.frame() %>% 
  rename(actorName = X2,
         characterName = X4) %>% 
  filter(actorName != '') %>% 
  select(-X1, -X3) %>% 
  mutate(characterName = trimws(
    gsub('/ ...|#|Dr.|\\n', '',
         sapply(strsplit(characterName, '\\d',"-"), `[`, 1))),
    mainCharacter = as.factor(
      grepl(mainCharacter, tolower(characterName))),
    recurringCharacter = as.factor(
      grepl(reccurringCharacter, tolower(characterName))),
    firstName = sapply(strsplit(characterName, ' '), `[`, 1)) -> characterInfo