restaurants <- 'volant|chez chez|cochon noir|heureux|chez henri|anya|happy brothers|chicken chicken'

episodes %>%
  filter(!is.na(gender)) %>% 
  group_by(season) %>% 
  count(gender) %>% 
  ggplot(aes(season, n)) +
  geom_smooth() +
  facet_wrap(~gender, scales = "fixed") +
  ggtitle("Battle of the sexes: Spoken lines on Frasier") +
  xlab("Season") +
  ylab("Count") + 
  theme(plot.title = 
          element_text(
            family = "Trebuchet MS", 
            color = "#666666", 
            face = "bold",
            size = 22,
            hjust = 0.5)) +
  theme(axis.title = 
          element_text(
            family = "Trebuchet MS",
            color = "#666666",
            face = "bold", 
            size = 12,
            hjust = 0.5))

episodes %>%
  filter(!is.na(gender)) %>% 
  group_by(gender) %>% 
  summarize(uniqueCharacterCount = n_distinct(character)) %>% 
  knitr::kable()

missingGender <- episodes %>% 
  filter(is.na(gender)) %>% 
  count(character, sort = TRUE)

episodes %>% 
  filter(gender == 'female',
         !grepl('woman|waitress|girl|daphne|roz', tolower(character))) %>% 
  group_by(character) %>% 
  count(season, sort = TRUE) %>% 
  ungroup() %>% 
  count(character, sort = TRUE) %>% 
  top_n(10) %>% 
  inner_join(episodes, by = "character") %>% 
  group_by(character) %>% 
  count(season, sort = TRUE) %>% 
  ggplot(aes(season, n)) +
  geom_smooth() +
  facet_wrap(~character) +
  ggtitle("Share of Lines by Female Characters") +
  xlab("Season") +
  ylab("Count") + 
  theme(plot.title = 
          element_text(
            family = "Trebuchet MS", 
            color = "#666666", 
            face = "bold",
            size = 22,
            hjust = 0.5)) +
  theme(axis.title = 
          element_text(
            family = "Trebuchet MS",
            color = "#666666",
            face = "bold", 
            size = 12,
            hjust = 0.5))