library(tidyverse)
library(dplyr)
library(XML)
library(jsonlite)
library(rvest)
library(xml2)
library(dplyr)
library(arsenal)

#XML import and convert to df
xml_file <- read_xml("https://raw.githubusercontent.com/awrubes/Data607_Assignment7/main/books.xml")
print(xml_file)

x <- xml_children(xml_file)

print(x)


xml_df <- data.frame(
  bookTitle = xml_text(xml_find_all(x, "bookTitle")),
  authors = xml_text(xml_find_all(x, "authors")),
  yearPublished = xml_text(xml_find_all(x, "yearPublished")),
  publisher = xml_text(xml_find_all(x, "publisher")),
  stringsAsFactors = FALSE
)

View(xml_df)

#json file import and convert to df
json_file <- "https://raw.githubusercontent.com/awrubes/Data607_Assignment7/main/books.json"
json_df <- fromJSON(json_file)
json_df <- as.data.frame(json_df)
View(json_df)

#html table import and convert to df
html_file <- read_html("https://raw.githubusercontent.com/awrubes/Data607_Assignment7/main/books.html")
html_df <- html_table(html_nodes(html_file, "table")[[1]], fill = TRUE)
View(html_df)

colnames(html_df)
colnames(xml_df)
colnames(json_df)

str(html_df)
str(xml_df)
str(json_df)

xml_df$yearPublished <- as.numeric(xml_df$yearPublished)

comparedf(html_df, xml_df)
comparedf(html_df, json_df)
comparedf(json_df, xml_df)
