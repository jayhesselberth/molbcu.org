library(tidyverse)
library(rvest)

faculty_html <- read_html("http://www.ucdenver.edu/academics/colleges/medicalschool/programs/Molbio/faculty/Pages/Molbio%20Faculty%20Main%20Page.aspx")

faculty <- faculty_html %>%
  html_node(".ms-listviewtable") %>%
  html_nodes("td a") %>%
  html_attr("href")
  