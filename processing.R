rm(list = ls())
library(tinytex)
library(rmarkdown)
library(googledrive)
library(qrcode)
library(random)
library(gitr)

## ---- ## ---- ## ---- ##
participant <- "Prova"
# data_file <- ""
## ---- ## ---- ## ---- ##


temp_folder <- "./temp/"

# save participant info
write.table(participant,
            paste0(temp_folder,"participant.txt"),
            append = FALSE,
            quote = FALSE,
            row.names = FALSE,
            col.names = FALSE)


###
random_code <- randomStrings(n = 1)
certificates_path <- "./certificates/"

# certificate_filename <- paste0(participant, "_", random_code, ".pdf")
certificate_filename_html <- paste0(participant, "_", random_code, ".html")

file.create(paste0(certificates_path, certificate_filename_html))
# file.create(paste0(certificates_path, certificate_filename))

link <- NULL
while (length(link) == 0){
    link <- drive_link(certificate_filename_html)
}

qr_img <- qr_code(link)


generate_svg(qr_img, 
             filename = paste0(temp_folder,"current_qr.svg"), 
             size = 100, 
             show = FALSE)

## 
output <- rmarkdown::render(input = "generate_certificate.Rmd",
                  # output_format = "pdf_document",
                  output_file = certificate_filename_html, 
                  output_dir = certificates_path)

# pagedown::chrome_print(output)

# git config --global user.email "mattia.doro@gmail.com"
# git config --global user.name "Goldmatthew"
gaa() # git add .
gcc() # git commit
gp()  # git push

