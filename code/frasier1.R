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