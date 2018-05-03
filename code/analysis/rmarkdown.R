# Render RMD file for Act One
rmarkdown::render("rmd/subtitleAnalysis.RMD",
                  'github_document',
                  '../analysis/actI.md')

# Render RMD file for Act Two
rmarkdown::render("rmd/transcriptAnalysis.RMD",
                  'github_document',
                  '../analysis/actII.md')

# Render RMD file for Act Three
rmarkdown::render("rmd/kitchenSinkAnalysis.Rmd",
                  'github_document',
                  '../analysis/actIII.md')