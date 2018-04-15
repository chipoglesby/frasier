# Load libraries
library(tidyverse)
library(tidytext)
library(gender)
library(magrittr)
library(lubridate)
# devtools::install_github("fkeck/subtools")
library(subtools)
library(rvest)

# Run source files as needed
source('code/loadRDS.R')

# If you want to run the scripts again:
source('code/imdbActorInfo.R')
source('code/seasonMetadata.R')
source('code/load.R')
source('code/loadSRT.R')
source('code/srtAnalysis.R')
source('code/analysis.R')