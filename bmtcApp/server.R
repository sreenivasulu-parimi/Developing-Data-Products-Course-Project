#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(dplyr)

#Read the data
bmtc_routes <- read.csv("bmtc_routes.csv", stringsAsFactors = FALSE)

# Define server logic required to draw a bmtc route map
shinyServer(function(input, output) {
      # To create UI elements 'route_no' dynamically
      output$routeOutput <- renderUI({
            selectInput("routeInput", "Route Number",
                  sort(unique(bmtc_routes$route_no)),
                  selected = "500A" #Defaul route number
            )
      })
      
      #filtered variable contains reactive variable with only selected route number data
      filtered <- reactive({
            #when we first run the app, each of the two outputs are throwing 
            #an error message, but the error message goes away after a second.
            #The problem is that when the app initializes, 'filtered' is trying
            #to access the route input, but the route input hasn't been created yet.
            #After Shiny finishes loading fully and the route input is generated,
            #'filtered' tries accessing it again, this time it's successful, and 
            #the error goes away.
            
            #Check if the route input exists, and if not then just return NULL.
            if(is.null(input$routeInput)) {
                  return(NULL)
            }
            bmtc_routes %>%
                  filter(
                        #filters the data with selected route number
                        bmtc_routes$route_no == input$routeInput
                  )
      })
      
      output$bmtcMap <- renderLeaflet({
            #when the render function tries to access the data, they will get a NULL value before
            #the app is fully loaded. We will still get an error, because the leaflet function will not 
            #work with a NULL dataset, so we also need to make a similar check in the renderLeaflet()
            #function. Only once the data is loaded, we can try to draw map.
            if(is.null(filtered())) {
                  return()
            }
            bmtc_route_map <- leaflet() %>%
                  addTiles()
            bmtc_route_map <- bmtc_route_map %>%
                  addMarkers(
                        lat = as.numeric(filtered()[3][[1]]), #List subsetting to select latitude
                        lng = as.numeric(filtered()[4][[1]]), #List subsetting to select longitude
                        popup = as.character(filtered()[2][[1]]) #List subsetting to select busstop
                  )
      })
      #The renderTable() function doesn't need this fix applied because Shiny doesn't have a
      #problem rendering a NULL table.
      output$results <- renderTable({
            filtered()[2]
      })
      
})
