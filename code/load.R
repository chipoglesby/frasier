# Load libraries
library(tidyverse)

# Read one script in to test with
frasier <- readLines("scripts/0101.txt")

# Get just the actual script itself
frasierNew <- frasier[62:length(frasier)]

frasierTest <- gsub('\\s{2,}', ' ',
                    gsub('\\s{3,}', " ",
                         paste(frasier[62:length],
                               collapse = " ")))

# Use this to remove extra spaces in the script
gsub('^\\s{1,}', '', frasier)

# Finder Character Lines
characterLines <- grep("\\s{1,}\\w\\:|\\w\\:", frasierNew)

# Find Empty Lines
emptyLines <- grep('^$', frasierNew)