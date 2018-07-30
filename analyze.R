library(tidyverse)

hours <- read_tsv("data/school-hours.tsv")

hours_by_course <- hours %>% separate(note, c("course", "activity"), sep = ", ") %>% separate(course, c("course", "project"), sep="/")

fixed_courses <- hours_by_course %>% filter(course != 'UO')

history_courses <- hours_by_course %>% filter(substr(course, 1, 3) == 'HIS')
polsci_courses <- hours_by_course %>% filter(substr(course, 1, 3) == 'POL')

polsci_courses
