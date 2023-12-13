# Calculate Producer and User Accuracy and F1 

library(sf)
library(dplyr)
detection <- st_read(r"{D:\wsf-sat\methods\detection\threshold_nbr\nbr_threshold_m12_postprocessing_2018_2022_harz\detection_nbr_m12_gee_postprocessing_2018_2022_harz.shp}") 
reference <- st_read(r"{D:\wsf-sat\data\validation\Harz_Freiflaeche_Totholz_2018_2022\Harz_Freifl_Totholz_2018_2022_025ha_fix_ni_dissolve_npharz_clip_basisdlm2019.shp}") %>% 
                      st_transform(st_crs(detection))

detection$area_m2 <- st_area(detection)
reference$area_m2 <- st_area(reference)

#intersection <- st_intersection(detection, reference)
intersection <- st_read(r"{D:\wsf-sat\methods\validation\intersection_over_union_nbr_diff_gee\IntersectOverUnion.gdb}", layer= "intersect_detection_nbr_m12_gee_postprocessing_2018_2022_harz")

intersection$area_m2 <- st_area(intersection)

TP <- sum(intersection$area_m2)
FN <- sum(reference$area_m2) - TP
FP <- sum(detection$area_m2) - TP

prod_acc = TP/(TP+FN)
user_acc = TP/(TP+FP)
               
round(user_acc,2)
round(prod_acc,2)

f1 = (2*prod_acc*user_acc)/(prod_acc+user_acc)
round(f1,2)

