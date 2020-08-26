#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(fs)
library(reticulate)

import("pandas")
import("scikit")

#reticulate::virtualenv_create("debunk")
# reticulate::virtualenv_install("debunk",
#                                packages = c("pandas", "scikit-learn", "joblib"))
#reticulate::use_virtualenv("debunk")
#reticulate::py_install(c("pandas", "scikit-learn", "joblib"))

if (fs::file_exists("python_model.joblib")) {
    print("Python model already exists, no need to re-run python script.")
} else {
    print("Python model does not exist, running python model creation script")
    reticulate::source_python("./01-create_model.py")
}

print(reticulate::py_config())

reticulate::source_python("./02-load_model.py")

X_test_scaled

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
