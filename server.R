require(dplyr, quietly=TRUE, warn.conflicts=FALSE)
atrocities = read.csv('data/map_data.csv')
atrocities = filter(atrocities, start.year>=1995)
atrocities = atrocities[!is.na(atrocities$lat),]
atrocities = atrocities[!is.na(atrocities$lon),]
atrocities$ym = paste(atrocities$start.month, atrocities$start.year, sep='/')
atrocities = arrange(atrocities, start.year, start.month)
atrocities$id = cumsum(!duplicated(atrocities$ym))


shinyServer(function(input, output) {
  require(leaflet)
  require(dplyr)
  output$map = renderLeaflet({
    points = filter(atrocities, substr(atrocities$date,1,7) == substr(input$Month,1,7))
    #points = atrocities[which(atrocities$id==input$Month),]
    leaflet(points) %>%
      # base map
      addProviderTiles("CartoDB.Positron") %>%
      # set bounds
      setView(0,0, zoom=2) %>%
      # add circle
      addCircleMarkers(lng = ~lon, lat = ~lat, radius = 3, fillOpacity = 0.5, color='#F00', popup=~paste(paste('Country:', country, sep=' '), 
                                                                                                         paste('Date:', date, sep=' '), 
                                                                                                         paste('Fatalities:', deaths.number, sep=' '),
                                                                                                         paste('Perpetrator:', perp.state.role, sep=' '),
                                                                                                         paste('Weapons used:', weapons, sep=' '),
                                                                                                         sep='<br/>'))
  })
})
