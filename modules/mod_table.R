library(shiny)
library(DT)

tableUI <- function(id){
  
  ns <- NS(id)
  
  DTOutput(ns("table"))
  
}

tableServer <- function(id,data){
  
  moduleServer(
    
    id,
    
    function(input,output,session){
      
      output$table <- renderDT({
        
        datatable(
          
          data()%>%
            
            select(
              
              NCT.Number,
              Sex,
              Age,
              Phases,
              Enrollment,
              Funder.Type,
              Study.Type
              
            ),
          
          extensions="Buttons",
          
          options=list(
            
            pageLength=15,
            
            scrollX=TRUE,
            
            dom='Bfrtip',
            
            buttons=c(
              'copy',
              'csv',
              'excel'
            )
            
          )
          
        )
        
      })
      
    }
    
  )
  
}