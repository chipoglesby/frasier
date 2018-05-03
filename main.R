#Load Libraries
source('libraries.R')

# Run source files as needed
source('code/rds/loadRDS.R')

# If you want to run the scripts again:
source('code/prep/characterInfo.R')
source('code/prep/seasonMetadata.R')
source('code/prep/load.R')
source('code/prep/loadSRT.R')
source('code/analysis/srtAnalysis.R')
source('code/analysis/transcriptAnalysis.R')
source('code/plots/transcriptPlots.R')
source('code/plots/srtPlots.R')
source('code/analysis/rmarkdown.R')

# Save your RDS files when done
source('code/rds/saveRDS')
