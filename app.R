library(shiny)
library(shinyWidgets)
library(dslabs)
library(tidyverse)
library(plotly)
library("readxl")
#house <- read_excel("~/R_shiny_app_midterm/Data/Analysis_Data.xlsx")
#house <- read_excel("~/fatmaaerr/R_shiny_app_midterm/Data/Analysis_Data.xlsx")

house <- read_excel("Analysis_Data.xlsx",header = T,stringsAsFactors = F)
house <- mutate(house, square_meter_price = Price/(Gross_Square_Meter) ) %>% 
  pivot_longer(cols = c(Price, square_meter_price), 
               names_to = "data", values_to = "value")

ui <- fluidPage(
  
  titlePanel("R Shiny App Istanbul Real Estate Valuation"),
  sidebarLayout(
    sidebarPanel(
      # inputs
      
      img(src = "Istanbul.jpg", height = 189, width = 700),
      
      
      selectizeInput("DistrictInput", "District",
                     choices = unique(house$District),  
                     selected="Bakirkoy", multiple =TRUE), 
      
      checkboxGroupInput("ageInput", "Building Age",
                         choices = unique(house$Building_Age), 
                         selected = c("0_5")),
      checkboxGroupInput("RoomInput", "Number of Rooms",
                         choices = unique(house$Number_of_rooms), 
                         selected = c("4")),
      
      sliderInput("priceInput", "Price", min=20000, max=21000000, 
                  value=c(20000, 21000000), sep=""),
      
      radioGroupButtons("dataInput", "Data",
                        choiceNames = list("Price", "Unit Square Meter Price"),
                        choiceValues = list("Price", "square_meter_price"))
      
      
        
      
    ),
    
    mainPanel(
      plotOutput("diseaseplot"),
      br(), br(),
      verbatimTextOutput("stats"), 
      br(), br(),
      plotlyOutput("distplot")
     
    ) 
  )   
) 


server <- function(input, output) {
  
  d <- reactive({
    house %>%
      filter(District %in% input$DistrictInput,
             Building_Age %in% input$ageInput,
             Number_of_rooms %in% input$RoomInput,
             value >= input$priceInput[1],
             value <= input$priceInput[2],
             data == input$dataInput)
  }) 
  
  
  output$diseaseplot <- renderPlot({
    
    ggplot(data = d(), aes(x=Gross_Square_Meter, y = value, color=District)) +
      geom_point(aes(color=District,shape=Heating_Type)) +
      theme_bw() +
      xlab("Gross Square Meter") +
      ylab(input$dataInput) +
      ggtitle("House pricing")
  })
  
  output$stats <- renderPrint({ 
  
    aggregate(value ~ District, data = d(), mean)

    
  })
  
  output$distplot <- renderPlotly({
    
    box <- plot_ly(d(), y = ~value,
                   color = ~District, type = "box")  %>%
      layout(title = "Distribution of House Pricing with District",
             yaxis = list(title=input$dataInput))
    
  })
  
}

shinyApp(ui=ui, server=server)
