# Assign exclusions for specific character names from bash scripts.
exclusions <- "skyline|dissolve|to|credits|title|they\'re|hallway|all|everyone|time|one|two|apartment|three|four|workplace|kacl|run|supra|switch|acres|africa|announcement|bangladesh|base|cabin|cafe|car|card|checkmate|chorus|club|computer|crew|date|here|hope|insert|listen|look|lounge"

# Assign character genders
missingMen <- 'santa|waiter|officer|guard|degas|freud|fras|husband|repairman|dad|father|workman|boys|patrolman|batman|bulldog'
missingWomen <- 'waitress|hostess|woman|mother|cheerleader|maid|women|mom|mum'

read_csv('data/csv/raw/lines.csv',
         col_names = c('lines', 'seasonEpisode')) %>%
  mutate(character = (sapply(strsplit(trimws(lines), ":"), "[", 1)),
         lines = (sapply(strsplit(trimws(lines), ":"), "[", 2)),
         lines = gsub('(\\[.*\\])', '', trimws(lines)),
         lines = gsub('(\\s{2,})', '', trimws(lines)),
         season = as.integer(substr(seasonEpisode, 0, 2)),
         episode = as.integer(substr(seasonEpisode, 3, 4))) %>%
  select(character, lines, season, episode) %>%
  filter(!grepl(exclusions,
                tolower(character)),
         !is.na(character),
         character != "",
         grepl('^[A-Z{1,}].*', character),
         nchar(character) >= 3) %>%
  # mutate(lines = sub("(!)|(\\.)|(\\?)|(\\.)|(\\-){1,}", "", tolower(lines))) %>%
  # mutate(lines = gsub("\\'|\\.|\\,|\\;|\\'", "", lines)) %>%
  filter(!is.na(lines)) %>% 
  mutate(character = ifelse(character == 'Tewksbury', 
                            'William Tewksbury', 
                            character)) -> transcripts

# Quickly find top characters:
transcripts %>%
  count(character, sort = TRUE) -> characters

characters %>%
  distinct(character) %>%
  group_by(character) %>%
  mutate(gender = gender(character)$gender[1]) %>%
  mutate(gender = ifelse(grepl(missingMen, tolower(character)),
                         "male", gender)) %>%
  mutate(gender = ifelse(grepl(missingWomen, tolower(character)),
                         'female', gender)) %>% 
  ungroup() -> characterGender

transcripts %<>% 
  left_join(characterGender, by = "character") %>% 
  inner_join(seasons, by = c(season = "season",
                            episode = "episode")) %>% 
  left_join(fullCastList, by = c('character' = 'firstName',
                         'season' = 'season',
                         'episode' = 'episode')) %>% 
  mutate(characterType = as.factor(ifelse(is.na(characterType), 
                                "other", 
                                as.character(characterType))),
         gender = as.factor(ifelse(is.na(gender), "other", gender)),
         act = NULL,
         actName = NULL,
         scene = NULL,
         sceneLocation = NULL) %>% 
  arrange(season, episode)

transcripts %>% 
  distinct(season,
           episode) %>% 
  mutate(episodeCount = row_number()) -> episodeCount

transcripts %<>%
  inner_join(episodeCount)

transcripts %>% 
  write_csv("data/csv/clean/transcripts.csv") %>% 
  saveRDS(., file = 'data/rds/transcripts.rds')

rm(exclusions)
rm(missingMen)
rm(missingWomen)
rm(characters)
rm(characterGender)
rm(episodeCount)