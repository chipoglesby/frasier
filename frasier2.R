for (i in 1:10) {
  ifelse(characterLines[i] <= emptyLines[i],
         print(paste0("Character is less than empty")),
         print(paste0("Empty is less than character")))
}

for (i in 1:10) {
  ifelse(characterLines[i] <= emptyLines[i],
         ifelse(characterLines[i] >= emptyLines[i], 
                print(paste0("Character is greater than empty")), 
                print(characterLines[i])),
         print(emptyLines[i]))
}

for (i in 1:10) {
  ifelse(characterLines[i] <= emptyLines[i],
         print(paste0("characterLines:", characterLines[i], " emptyLines:", emptyLines[i])),
         print(paste0("emptyLines:", emptyLines[i], ", characterLines:", characterLines[i])))
}


for (i in 1:10) {
  print(paste0("i is: ", i))
  i = i + 1
  print(paste0("Now i is: ", i))
}