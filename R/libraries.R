#----------------------------------------------------------
# Package Loader Function
#----------------------------------------------------------

load_packages <- function(pkgs) {
  
  installed <- rownames(installed.packages())
  
  for (pkg in pkgs) {
    
    if (!(pkg %in% installed)) {
      
      install.packages(
        pkg,
        dependencies = TRUE
      )
      
    }
    
    library(pkg, character.only = TRUE)
    
  }
  
}

# Required packages
required_packages <- c(
  "shiny",
  "shinydashboard",
  "shinyWidgets",
  "bslib",
  "tidyverse",
  "lubridate",
  "stringr",
  "plotly",
  "echarts4r",
  "reactable",
  "DT"
)

load_packages(required_packages)