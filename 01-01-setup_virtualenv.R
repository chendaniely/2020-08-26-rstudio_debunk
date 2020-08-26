# Should only need to run this script once per machine

library(reticulate)

# shinyapps.io has virtualenv installed
# https://docs.rstudio.com/shinyapps.io/appendix.html#default-system-packages
# https://community.rstudio.com/t/how-to-use-conda-environment-in-shinyapps-io/

envs <- virtualenv_list()

if ("debunk" %in% envs) {
  print("Not creating new 'debunk' virtualenv")
} else {
  virtualenv_create("debunk")
  virtualenv_list()
}

use_virtualenv("debunk")
