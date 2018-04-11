for (i in 1:10) {
  if(characterLines[i] <= emptyLines[i]) {
    n <- emptyLines[i] - 1
    print(paste0(characterLines[i],':', n))
  } else {
    print(characterLines[i])
  }
}


for (i in 1:10) {
  h <- i + 1
if(emptyLines[i] <= characterLines[h] & emptyLines[i] <= characterLines[h]) {
  print(TRUE)
  } else {
    n <- i + 1
    j <- characterLines[n] - 1
    print(paste0(characterLines[i],':', j))
  }
}

characterLines[1:10]
emptyLines[1:10]

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

# A bunch of test loop ideas I have to see what will work

# Loop through characterLines and emptyLines
for (i in 1:10) {
  ifelse(characterLines[i] <= emptyLines[i],
         print(paste0("characterLines:", 
                      characterLines[i], 
                      " emptyLines:", 
                      emptyLines[i])),
         print(paste0("emptyLines:", 
                      emptyLines[i], 
                      ", characterLines:", 
                      characterLines[i])))
}

for (i in 1:10) {
  print(paste0(i, 
               " in characterLines:", 
               characterLines[i]))
  print(paste0(i, 
               " in emptyLines: ", 
               emptyLines[i]))
}

# Here, I'm trying to find a way to identify when a
# character is actually speaking.
for (i in 1:10) {
  if(characterLines[i] <= emptyLines[i]) {
    n <- emptyLines[i] - 1
    print(paste0(characterLines[i],':', n))
  } else {
    print(characterLines[i])
  }
}

# Another test to find when a character is speaking
for (i in 1:10) {
  h <- i + 1
  if(emptyLines[i] <= characterLines[h] & emptyLines[i] <= characterLines[h]) {
    print(TRUE)
  } else {
    n <- i + 1
    j <- characterLines[n] - 1
    print(paste0(characterLines[i],':', j))
  }
}

# A test to see when a character would be speaking.
for (i in 1:10) {
  ifelse(characterLines[i] <= emptyLines[i],
         print(paste0("Character is less than empty")),
         print(paste0("Empty is less than character")))
}

# Another loop test
for (i in 1:10) {
  ifelse(characterLines[i] <= emptyLines[i],
         ifelse(characterLines[i] >= emptyLines[i], 
                print(paste0("Character is greater than empty")), 
                print(characterLines[i])),
         print(emptyLines[i]))
}

# Another loop test
for (i in 1:10) {
  ifelse(characterLines[i] <= emptyLines[i],
         print(paste0("characterLines:", characterLines[i], " emptyLines:", emptyLines[i])),
         print(paste0("emptyLines:", emptyLines[i], ", characterLines:", characterLines[i])))
}


# Just a random loop test that uses addition
for (i in 1:10) {
  print(paste0("i is: ", i))
  i = i + 1
  print(paste0("Now i is: ", i))
}


for (i in 1:10) {
  j <- i + 1
  k <- emptyLines[i] - 1
  if(emptyLines[i] >= characterLines[i] & emptyLines[i] <= characterLines[j])
    print(i)
  print(k)
  # print(frasier2[i:k])
}

characterLines[1:10]
emptyLines[1:10]


emptyLines[1] >= characterLines[1] & emptyLines[1] <= characterLines[2]


frasier2[1:16]