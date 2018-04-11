frasier = readLines("scripts/0101.txt")

text <- gsub('\\s{2,}', ' ',
     gsub('\\s{3,}', " ",
          paste(frasier[62:length],
                collapse = " ")))
# Use this
gsub('^\\s{1,}', '', frasier)

# Finder Character Lines
characterLines <- grep("\\s{1,}\\w\\:|\\w\\:", frasier2)

# Find Empty Lines
emptyLines <- grep('^$', frasier2)

# Loop through
for (i in 1:10) {
  ifelse(characterLines[i] <= emptyLines[i],
         print(paste0("characterLines:", characterLines[i], " emptyLines:", emptyLines[i])),
         print(paste0("emptyLines:", emptyLines[i], ", characterLines:", characterLines[i])))
}

for (i in 1:10) {
  print(paste0(i, " in characterLines:", characterLines[i]))
  print(paste0(i, " in emptyLines: ", emptyLines[i]))
}