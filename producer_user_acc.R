library(renv)
library(sf)
library(dplyr)

detection <- st_read(r"{D:\wsf-sat\methods\validation\intersect_over_union_rf\input_detection\harz_2019\detection_2019_harz.shp}") %>% st_transform(25832)
reference <- st_read(r"{D:\wsf-sat\data\validation\Harz_Freiflaeche_Totholz_2018_2021\Harz_Freifl_Totholz_2019_ni.shp}")

detection$area_m2 <- st_area(detection)
reference$area_m2 <- st_area(reference)

intersection <- st_intersection(detection, reference)

intersection$area_m2 <- st_area(intersection)

TP <- sum(intersection$area_m2)
FN <- sum(reference$area_m2) - PA
FP <- sum(detection$area_m2) - PA

prod_acc = TP/(TP+FN)
user_acc = TP/(TP+FP)
               
user_acc
prod_acc
