library(shiny)
library(dplyr)

filterUI <- function(id){
  
  ns <- NS(id)
  
  tagList(
    
    dateRangeInput(
      ns("daterange"),
      "Completion Date"
    ),
    
    selectInput(
      ns("location"),
      "Location Country",
      choices=NULL,
      multiple=TRUE
    ),
    
    selectInput(
      ns("funder"),
      "Funder Type",
      choices=NULL,
      multiple=TRUE
    ),
    
    selectInput(
      ns("studytype"),
      "Study Type",
      choices=NULL,
      multiple=TRUE
    ),
    
    selectInput(
      ns("status"),
      "Study Status",
      choices=NULL,
      multiple=TRUE
    )
    
  )
  
}

filterServer <- function(id,data){
  
  moduleServer(
    
    id,
    
    function(input,output,session){
      
      observe({
        
        updateSelectInput(session,"location",
                          choices=sort(unique(data$Location_country)),
                          selected=unique(data$Location_country))
        
        updateSelectInput(session,"funder",
                          choices=sort(unique(data$Funder.Type)),
                          selected=unique(data$Funder.Type))
        
        updateSelectInput(session,"studytype",
                          choices=sort(unique(data$Study.Type)),
                          selected=unique(data$Study.Type))
        
        updateSelectInput(session,"status",
                          choices=sort(unique(data$Study.Status)),
                          selected=unique(data$Study.Status))
        
      })
      
      reactive({
        
        df <- data
        
        if(!is.null(input$daterange)){
          
          df <- df %>%
            filter(
              Completion.Date>=input$daterange[1],
              Completion.Date<=input$daterange[2]
            )
          
        }
        
        df %>%
          filter(
            
            Location_country %in% input$location,
            
            Funder.Type %in% input$funder,
            
            Study.Type %in% input$studytype,
            
            Study.Status %in% input$status
            
          )
        
      })
      
    })
  
}