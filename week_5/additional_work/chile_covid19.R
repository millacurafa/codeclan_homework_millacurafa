library(leaflet)
library(dplyr)
library(shinythemes)
library(shiny)

covid_chile <- tibble(
  "region" = c("Arica y Parinacota",
               "Tarapacá",
               "Antofagasta",
               "Atacama",
               "Coquimbo",
               "Valparaíso",
               "Metropolitana",
               "O’Higgins",
               "Maule",
               "Ñuble",
               "Biobío",
               "Araucanía",
               "Los Ríos",
               "Los Lagos",
               "Aysén",
               "Magallanes"),
  "casos_nuevos" = c(1,1,1,0,1,12,64,3,1,3,14,37,3,16,1,6),
  "casos_totales" = c(3,5,20,1,13,44,746,14,31,114,109,111,14,60,2,19),
  "%_casos_totales" = signif(casos_totales/sum(casos_totales)*100, 2),
  "fallecidos" = c(0,0,0,0,0,0,3,0,0,0,1,0,0,0,0,0),
  "latitud" = c(-18.4745998, -20.2132607, -23.6523609, -27.3667908,	-29.9533195, -33.0359993,	-33.4569397, -34.1708298,	-35.4263992, -36.6066399, -36.8269882, -38.7396507, -39.8142204, -41.4692993, -45.5752411, -53.1548309),
  "longitud" = c(-70.2979202, -70.1502686, -70.395401, -70.331398, -71.3394699, -71.629631, -70.6482697, -70.7444382, -71.6554184, -72.1034393, -73.0497665, -72.5984192, -73.2458878, -72.9423676, -72.0661926, -70.911293)
)

pal <- colorNumeric(
  palette = "Blues",
  domain = covid_chile$casos_totales)

leaflet(covid_chile) %>% 
  addTiles() %>% 
  addCircleMarkers(lat = ~latitud, lng = ~longitud, popup = ~region) 
  #%>% 
  # addPolygons(stroke = FALSE, smoothFactor = 0.2, fillOpacity = 1,
  #             color = ~pal(casos_totales))
  
# 
# library(CodeClanData)
# leaflet(whisky) %>% 
#   addTiles() %>%
#   addCircleMarkers(lat = ~Longitude, lng = ~Latitude, popup = ~Distillery)
# 
