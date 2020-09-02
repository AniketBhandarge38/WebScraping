library(xml2)
library(rvest)
library(stringr)

url <- 'https://www.amazon.in/Apple-iPhone-11-64GB-Black/dp/B07XVMDRZY/ref=pd_vtp_107_4/258-1081828-5439527?_encoding=UTF8&pd_rd_i=B07XVMDRZY&pd_rd_r=a01594a1-bd4b-42e1-9eaa-9e813236c126&pd_rd_w=6n0Cq&pd_rd_wg=w6MQs&pf_rd_p=1605a9ef-9762-49bc-b130-0216f64a8e27&pf_rd_r=AAQR3SMV6R35X8Y81ZFA&psc=1&refRID=AAQR3SMV6R35X8Y81ZFA'

Amazonwebpage <- read_html(url)

title_html <- html_node(Amazonwebpage,'h1#title')
title <- html_text(title_html)
newTitle <- str_replace_all(title,"[\r\n]","")


price_html <- html_node(Amazonwebpage,'span#priceblock_dealprice')
price <- html_text(price_html)
newPrice <- str_replace_all(price,"[\u20b9]","")



details_html  <- html_node(Amazonwebpage,'div#feature-bullets')
details <- html_text(details_html)
newDetails <- str_replace_all(details, "[\r\n\t]","")



ratings_html <- html_node(Amazonwebpage,'span#acrPopover')
ratings <- html_text(ratings_html)
newRatings <- str_replace_all(ratings,"[\n]","")



size_html <- html_node(Amazonwebpage,'div#variation_size_name')
size <- html_text(size_html)
newSize <- str_replace_all(size,"[\n]","")



Product_Data <- data.frame(Title = newTitle, Price = newPrice,
                           Description = newDetails, Size = newSize,
                           Ratings = newRatings)

str(Product_Data)


library(jsonlite)

JsonData <- toJSON(Product_Data)
cat(JsonData)
