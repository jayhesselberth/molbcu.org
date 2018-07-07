library(tidyverse)
library(rvest)
library(jsonlite)

students_html <- read_html("http://www.ucdenver.edu/academics/colleges/medicalschool/programs/Molbio/Students/Pages/Students.aspx")

student_info <- function(node) {
  tibble(
    name = node_info(node, ".student_name"),
    degree = node_info(node, ".student_pos_degree"),
    mentor = node_info(node, ".student_mentor"),
    interest = node_info(node, ".student_res_int")
  )
}

node_info <- function(node, info) {
  node %>% html_node(info) %>% html_text() 
}

students <- students_html %>%
  html_nodes(".student_text_container") %>%
  purrr::map_df(student_info)

jsonlite::write_json(students, "data/students/data.json", pretty = TRUE)
