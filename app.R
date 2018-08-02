ui <- fluidPage(theme = shinytheme("cerulean"),
                titlePanel("2018 FIFA World Cup"),
                sidebarLayout(
                  sidebarPanel(
                    helpText("Choose a variable for the Y Axis"),
                    selectInput(inputId = "y", label = "Y Axis",
                                choices = c("Ball in Play (Minutes)"="BiP", "Length of Game (Minutes)"="TotalTime",
                                            "Ball in Play (%)" = "BiPTT.","Temperature (C)"="Temp", "Humidity (%)" = "Hum"),
                                selected = "BiP"),
                    helpText("Choose a variable for the X Axis"),
                    selectInput(inputId = "x", label = "X Axis",
                                choices = c("Game Number" ="GameID", "Ball in Play (Minutes)"= "BiP", "Ball in Play (%)" = "BiPTT."),
                                selected = "GameID"),
                    selectInput(inputId = "z",
                                label = "Colour By",
                                choices = c("Ball in Play (Minutes)"="BiP", "Length of Game (Minutes)"="TotalTime",
                                            "Ball in Play (%)" = "BiPTT.","Temperature (C)"="Temp", "Humidity (%)" = "Hum"),
                                selected = "BiP"),
                    checkboxInput(inputId = "show_data",
                                  label= "Show Data Table",
                                  value = TRUE)
                  ),
                  mainPanel(
                    plotOutput(outputId = "scatterplot"),
                    DT::dataTableOutput(outputId = "dftable")
                  )
                )
)
server <- function(input, output) {
  output$scatterplot <- renderPlot({
    ggplot(data = df, aes_string(x = input$x, y = input$y, colour=input$z)) +
      geom_point() +
      theme_bw()
  })
  output$dftable <- DT::renderDataTable(
    if(input$show_data){
      DT::datatable(data=df[,1:7],
                    options = list(pageLength=10),
                    rownames = FALSE)
    }
  )
}
shinyApp(ui = ui, server = server)
