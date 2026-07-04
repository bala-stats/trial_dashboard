library(shiny)
library(plotly)
library(dplyr)

plotUI <- function(id){
  
  ns <- NS(id)
  
  tagList(
    
    plotlyOutput(ns("age")),
    
    br(),
    
    plotlyOutput(ns("location")),
    
    br(),
    
    plotlyOutput(ns("sponsor"))
    
  )
  
}

plotServer <- function(id,data){
  
  moduleServer(
    
    id,
    
    function(input,output,session){
      
      #--------------------------
      # Graph1
      #--------------------------
      
      output$age <- renderPlotly({
        
        df <- data() %>%
          
          group_by(Age) %>%
          
          summarise(
            
            AverageEnrollment=mean(Enrollment,na.rm=TRUE)
            
          )
        
        plot_ly(
          
          df,
          
          x=~Age,
          
          y=~AverageEnrollment,
          
          type="bar"
          
        )
        
      })
      
      #--------------------------
      # Graph2
      #--------------------------
      
      output$location <- renderPlotly({
        
        df <- data() %>%
          
          group_by(Location_country) %>%
          
          summarise(
            
            Enrollment=sum(Enrollment,na.rm=TRUE)
            
          )
        
        plot_ly(
          
          df,
          
          x=~Location_country,
          
          y=~Enrollment,
          
          type="bar",
          
          text=~Enrollment,
          
          textposition="outside"
          
        )
        
      })
      
      #--------------------------
      # Graph3
      #--------------------------
      
      output$sponsor <- renderPlotly({
        
        df <- data() %>%
          
          count(Sponsor)
        
        plot_ly(
          
          df,
          
          x=~reorder(Sponsor,n),
          
          y=~n,
          
          type="bar"
          
        )
        
      })
      
    }
    
  )
  
}