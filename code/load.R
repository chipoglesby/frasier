lines <- read_csv('data/csv/lines.csv',
                  col_names = c('lines', 'seasonEpisode')) %>%
  mutate(character = (sapply(strsplit(trimws(lines), ":"), "[", 1)),
         lines = (sapply(strsplit(trimws(lines), ":"), "[", 2)),
         lines = gsub('(\\[.*\\])', '', trimws(lines)),
         lines = gsub('(\\s{2,})', '', trimws(lines)),
         season = as.integer(substr(seasonEpisode, 0, 2)),
         episode = as.integer(substr(seasonEpisode, 3, 4))) %>%
  select(character, lines, season, episode) %>%
  filter(!grepl('dissolve|to|credits|title|they\'re|hallway|all|everyone|time',
                tolower(character)),
         !is.na(character),
         character != "",
         grepl('^[A-Z{1,}].*', character),
         nchar(character) >= 3) %>%
  mutate(lines = sub("(!)|(\\.)|(\\?)|(\\.)|(\\-){1,}", "", tolower(lines))) %>%
  mutate(lines = gsub("\\'|\\.|\\,|\\;|\\'", "", lines)) %>%
  mutate(key = gsub("(\\s|)", "", lines),
         key = gsub('[[:punct:]]', '', key))

# Quickly find top characters:
characters <- lines %>%
  count(character, sort = TRUE) 

# Assign character genders
missingMen <- 'santa|waiter|officer|guard|degas|freud|fras|husband|repairman|dad|father|workman|boys|patrolman|batman|bulldog'
missingWomen <- 'waitress|hostess|woman|mother|cheerleader|maid|women|mom|mum'

characterGender <- characters %>%
  distinct(character) %>%
  group_by(character) %>%
  mutate(gender = gender(character)$gender[1]) %>%
  mutate(gender = ifelse(grepl(missingMen, tolower(character)),
                         "male", gender)) %>%
  mutate(gender = ifelse(grepl(missingWomen, tolower(character)),
                         'female', gender)) %>% 
  ungroup()


lines %<>%
  inner_join(characterGender, by = "character") %>% 
  inner_join(seasons, by = c(season = "season",
                            episode = "episode")) %>% 
  left_join(mainCharacters, by = c('character' = 'firstName'))