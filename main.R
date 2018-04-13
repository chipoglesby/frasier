# Load libraries
library(tidyverse)
library(tidytext)
library(gender)
library(magrittr)
library(chron)
library(lubridate)
devtools::install_github("fkeck/subtools")
library(subtools)

# Run source files as needed
source('code/loadRDS.R')
source('code/saveRDS.R')