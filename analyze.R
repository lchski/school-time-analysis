library(tidyverse)

hours <- read_tsv("data/school-hours.tsv")

hours_by_course <- hours %>%
  separate(note, c("course", "activity"), sep = ", ") %>%
  separate(course, c("course", "project"), sep="/") %>% mutate(for_exam = case_when(
    project == "E" ~ TRUE,
    TRUE ~ FALSE
  ))

history_courses <- hours_by_course %>% filter(substr(course, 1, 3) == 'HIS')
polsci_courses <- hours_by_course %>% filter(substr(course, 1, 3) == 'POL')

polsci_courses %>% select(course) %>% unique()







## calcs
weekly_work_hours <- 8
weekly_course_hours <- 15
weeks_in_term <- 13
weekly_polisci_hours <- 2 * (polsci_courses %>% filter(! for_exam) %>% summarize(hours = sum(hours)) %>% pull(hours) / 2 / weeks_in_term)
weekly_history_hours <- 3 * (history_courses %>% filter(! for_exam) %>% summarize(hours = sum(hours)) %>% pull(hours) / 2 / weeks_in_term)

projected_weekly_active_hours <- sum(weekly_course_hours, weekly_history_hours, weekly_polisci_hours, weekly_work_hours)

weekly_lunch_hours <- (0.5 * 2) + (0.75 * 3)
weekly_travel_hours <- 0.5 + 0.5 + 0.75 + 0.5 + 0.75
projected_weekly_supporting_hours <- sum(weekly_lunch_hours)

projected_weekly_total_hours <- sum(projected_weekly_supporting_hours, projected_weekly_active_hours)

