library(shiny)
library(tidyverse)
library(lubridate)
library(plotly)
library(DT)
library(stringr)

source("R/libraries.R")
source("modules/mod_filter.R")
source("modules/mod_plots.R")
source("modules/mod_table.R")

#----------------------------
# Read Data
#----------------------------

trial_data <- read.csv(
  "data/all_studies.csv",
  stringsAsFactors = FALSE
)

trial_data$Completion.Date <- as.Date(trial_data$Completion.Date)

#--------------------------------------------------
# Create Location_country
#--------------------------------------------------

trial_data$Location_country <-
  sapply(strsplit(trial_data$Locations,"\\|"),function(x){
    
    countries <- sapply(x,function(y){
      
      trimws(tail(strsplit(y,",")[[1]],1))
      
    })
    
    paste(unique(countries),collapse=", ")
    
  })

ui <- fluidPage(
  
  titlePanel("Clinical Trial Data Visualization"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      filterUI("filters")
      
    ),
    
    mainPanel(
      
      plotUI("plots"),
      
      br(),
      
      tableUI("table")
      
    )
  )
)

server <- function(input, output, session){
  
  filtered_data <- filterServer(
    "filters",
    trial_data
  )
  
  plotServer(
    "plots",
    filtered_data
  )
  
  tableServer(
    "table",
    filtered_data
  )
  
}

shinyApp(ui,server)