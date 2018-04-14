# Load libraries
library(tidyverse)
library(tidytext)
library(gender)
library(magrittr)
library(chron)
library(lubridate)
# devtools::install_github("fkeck/subtools")
library(subtools)
library(rvest)

# Run source files as needed
# source('code/loadRDS.R')
# source('code/saveRDS.R')

# Run order:
source('code/seasonMetadata.R')
source('code/lines.R')
source('code/loadSRT.R')