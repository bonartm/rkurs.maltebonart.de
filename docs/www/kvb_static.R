# Load Libraries ----------------------------------------------------------

#install.packages('XML')
#install.packages('leaflet')
library("XML")
library("leaflet")

# Helper Function to extract bike from XML node ---------------------------

# extractBikes <- function(node) {
#   place <- xpathSApply(node, "@uid|@lat|@lng|@name|@bikes|@bike_numbers")
#   nbikes <- as.numeric(place["bikes"])
#   if (nbikes > 0)
#     return(place)
#   else
#     return(NULL)
# }
# 
# # Parse Data from API into a data.frame -----------------------------------
# 
# url <- "http://api.nextbike.net/maps/nextbike-live.xml?city=14"
# data <- xmlParse(url)
# bikes <- xpathApply(data, "//place", extractBikes)
# bikes <- data.frame(do.call(rbind, bikes), stringsAsFactors = FALSE)
# 
# # transform character lat, lng to numeric values
# bikes$lat <- as.numeric(bikes$lat)
# bikes$lng <- as.numeric(bikes$lng)

bikes <- readRDS("./www/bikes.rds")
# Visualize the data set --------------------------------------------------

m <- leaflet()
m <- addProviderTiles(m, "Stamen.TonerLite")
m <- setView(m, lat = 50.927132, lng = 6.924257, zoom = 16)
m <- addCircleMarkers(m, bikes$lng, bikes$lat, popup = bikes$bike_numbers,
                      stroke = F, color = "red", 
                      fillOpacity = 0.6)
m 
