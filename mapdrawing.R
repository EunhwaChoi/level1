# install.packages("Rtools")

# install.packages("devtools")

library(devtools)

library(readxl)

# devtools::install_github("cardiomoon/kormaps2014")

library(kormaps2014)
library(readxl)
library(tidyverse)

install.packages("ggiraphExtra")
install.packages("mapproj")
library(mapproj)
library(ggiraphExtra)

# getwd()

map <- read_xlsx("map.xlsx")

# str(map) 
# 
# map %>% 
#   filter(지역 == 1)
# 
# 
# map[map$지역 == 1,]$응답

map_2<- map %>% 
  group_by(지역) %>% 
  summarise(총응답 = mean(응답)) %>% 
  filter(지역 != "NA") 

map_2



korpop_eh <- korpop1 %>% 
  rename(pop = 총인구_명, name = "행정구역별_읍면동")

korpop_eh$name <- iconv(korpop_eh$name, "UTF-8","CP949")

korpop_eh$name

korpop_eh <- korpop_eh %>% 
  select(name,code)
  
korpop_eh <- korpop_eh[c(1:7, 9:16, 8, 17),]


total_map_data <- cbind(korpop_eh, map_2)


ggChoropleth(data = total_map_data,
             aes(fill = 총응답,
                 map_id = code,
                 tooltip = name),
             map = kormap1,
             palette = "PuBu",
             interactive = T)





