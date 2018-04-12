testSRT <- shows %>% 
  filter(!is.na(key)) %>% 
  inner_join(subtitles, by = "key") %>% 
  distinct(key, .keep_all = TRUE) %>% 
  select(-Text, -key)

testSRTAlternative <- shows %>% 
  filter(!is.na(key)) %>% 
  inner_join(subtitles, by = "key")

multiples <- testSRTAlternative %>% 
  count(lines, sort = TRUE) %>% 
  top_n(10)