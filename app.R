library(fortunes)
library(shiny)

num_fortunes <- nrow(read.fortunes())

ui <- fluidPage(
  titlePanel("Shiny Demo"),
  sidebarLayout(
    sidebarPanel(
      actionButton('randomise', "Randomise"),
      numericInput(
        'fortune_id',
        "Fortune ID",
        value = sample.int(num_fortunes, 1),
        min = 1,
        max = num_fortunes
      ),
      bookmarkButton()
    ),
    mainPanel(
      textOutput('fortune')
    )
  )
)

server <- function(input, output, session) {

  output$fortune <- renderText({
    fortune(input$fortune_id)$quote
  })

  observeEvent(input$randomise, {
    updateNumericInput(session, 'fortune_id',
                       value = sample.int(num_fortunes, 1))
  })

}

shinyApp(ui, server, enableBookmarking = "server")
