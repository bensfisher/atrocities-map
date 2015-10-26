library(shiny)
library(leaflet)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Atrocities Map 1995-2015"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("Month",
                  "Month:",
                  min=as.Date("1995-01-01"),
                  max=as.Date("2015-01-01"),
                  value=as.Date("1995-01-01"),
                  timeFormat="%b %Y")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      leafletOutput("map")
    )
  )
))