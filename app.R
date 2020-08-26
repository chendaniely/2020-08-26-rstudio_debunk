library(shiny)
library(ggplot2)
library(reticulate)

reticulate::use_condaenv("miniconda3")

if (fs::file_exists("python_model.joblib")) {
    print("Python model already exists, no need to re-run python script.")
} else {
    print("Python model does not exist, running python model creation script")
    reticulate::source_python("./01-create_model.py")
}

rm(list = ls())

reticulate::source_python("./02-load_model.py")

py$python_model # python objects can be found under py$
test_data       # certain python data structures are auto converted into R

ui <- fluidPage(
    titlePanel("Scikit-learn Breast Cancer Data"),
    
    fluidRow(
        column(2,
               sliderInput("test_cases",
                           "Number test cases:",
                           min = 1,
                           max = nrow(test_data),
                           value = 1),
               verbatimTextOutput("prediction")
        ),
        column(10,
               plotOutput("barplot"),
               verbatimTextOutput("python_config")
        )
    )
)

server <- function(input, output) {
    
    predictions <- reactive({
        if (input$test_cases == 1) {
            return(py$python_model$predict(t(test_data[1, ])))
        } else {
            return(py$python_model$predict(test_data[1:input$test_cases, ]))   
        }
    })
    
    output$barplot <- renderPlot({
        ggplot() + aes(predictions()) + geom_bar()
    })
    
    output$prediction <- renderPrint({
        predictions()
    })
    
    output$python_config <- renderPrint({
        reticulate::py_config()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
