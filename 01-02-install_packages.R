library(reticulate)

use_virtualenv("debunk")

virtualenv_install("debunk", packages = c("pandas", "scikit-learn"))

#pandas <- import("pandas")
