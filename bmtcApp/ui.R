#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)


#bmtc_routes <- read.csv("bmtc_routes.csv", stringsAsFactors = FALSE)
#print(unique(bmtc_routes))

# Define UI for application that draws a bmtc route map
shinyUI(fluidPage(
  
  # Application title
  titlePanel("BMTC (Bangalore Metropolitan Transport Corporation) Route Map"),
  
  # choices with a select input for the list of route numbers
  sidebarLayout(
        sidebarPanel(
              uiOutput("routeOutput") # To create UI elements 'route_no' dynamically
        ),
        
        # Show a map and list of bus stops of the selected route number
        mainPanel(
              h4("Google Map"),
              leafletOutput("bmtcMap"), #shows map
              br(), br(), # two spaces in b/w bmtcMap and results
              h4("List of bus stops"),
              tableOutput("results") #show list of bus stops
        )
  )
))
