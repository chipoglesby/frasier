# Load libraries
library(tidyverse)
library(tidytext)
library(gender)
library(magrittr)
library(lubridate)
# devtools::install_github("fkeck/subtools")
library(subtools)
library(rvest)
library(viridis)
library(hrbrthemes)
library(sentimentr)
library(ggstance)

# Run source files as needed
source('code/rds/loadRDS.R')

# If you want to run the scripts again:
source('code/prep/imdbActorInfo.R')
source('code/prep/seasonMetadata.R')
source('code/prep/load.R')
source('code/prep/loadSRT.R')
source('code/prep/srtAnalysis.R')
source('code/prep/analysis.R')

# Save your RDS files when done
source('code/rds/saveRDS')
