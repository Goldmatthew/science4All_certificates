rm(list = ls())
library(tinytex)
library(rmarkdown)
library(googledrive)
library(qrcode)
library(random)
library(gert)

## ---- ## ---- ## ---- ##
participant <- "Prova2"
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

#create the QR code
qr_img <- qr_code(link)

# create a svg image of the qrcode
generate_svg(qr_img, 
             filename = paste0(temp_folder,"current_qr.svg"), 
             size = 100, 
             show = FALSE)

# generate the html report
output <- rmarkdown::render(input = "generate_certificate.Rmd",
                  # output_format = "pdf_document",
                  output_file = certificate_filename_html, 
                  output_dir = certificates_path)

# convert html file in pdf
# pagedown::chrome_print(output)

# Open the pdf file
# browseURL(normalizePath(paste0("./certificates/", certificate_filename)))


# gert::git_add() # adding
gert::git_add("certificates/")
gert::git_commit("new_certificate")
gert::git_push()
cli::cli_alert_success("The certificate has been uploaded on Github!")




