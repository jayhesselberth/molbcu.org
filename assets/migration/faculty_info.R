library(tidyverse)
library(rvest)
library(jsonlite)

faculty_html <- read_html("http://www.ucdenver.edu/academics/colleges/medicalschool/programs/Molbio/faculty/Pages/Molbio%20Faculty%20Main%20Page.aspx")

faculty <- faculty_html %>%
  html_node(".ms-listviewtable") %>% 
  html_table(fill = TRUE) %>%
  as_tibble() %>%
  setNames(c("name", "interest")) %>%
  tidyr::separate(name, into = c("last", "first"), sep = ",") %>%
  mutate(name = paste(str_trim(first), str_trim(last))) %>%
  select(name, interest)

jsonlite::write_json(faculty, "data/faculty/data.json", pretty = TRUE)
