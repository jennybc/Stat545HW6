outputs <- c("Canucks.csv",            # NHL.pt1.Rmd
             list.files(pattern = "*.pdf$"))
file.remove(outputs)

## run my scripts
source("NHL.pt1.R")
source("NHL.pt2.R")
