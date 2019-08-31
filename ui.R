
library(shiny)
library(ggplot2)
dataset<-mtcars
shinyUI(fluidPage(
    
    titlePanel("Project Shiny!"),
    mainPanel(
        h4("This App contains 3 tabs:"),
        HTML("<b> Exploratory Analysis</b> tab can be used to perform exploratory analysis on mtcars dataset <br><b> 
           Linear Regression</b> tab can be used for performing linear regression on mtcars dataset <br> <b> Linear Regression on sample</b> tab can be used for performing linear
           regression on a sample of mtcars dataset. The sample can be selected using a brush."),
    
    
    tabsetPanel(
        type="tabs",
        tabPanel("Exploratory Analysis
                 ",
                 br(),

                 h1("Exploratory Analysis on MtCars"),
                 sidebarLayout(
                     sidebarPanel(
                         sliderInput("n","Number of Observations?",10,nrow(dataset),value=10,step=5),
                         selectInput("xvar","X",names(dataset)),
                         selectInput("yvar","Y",names(dataset)),
                         selectInput("colorvar","Color",names(dataset)),
                         checkboxInput("smooth","smoothing curve?",value=FALSE)
                     ),
                     mainPanel(
                         h2("PLOT"),
                         plotOutput("xyplot")
                     )
                 )
                 
                 
        ),
        tabPanel("Linear Regression",
                 br(),
                 
                 h1("Linear Regression on MTcars"),
                 sidebarLayout(
                     sidebarPanel(
                         textInput("box1","Tab2 Heading?",value="Linear Regression"),
                         sliderInput("slider1","Select mpg to predict disp!",5,35,value=20),
                         h3("Intercept:"),
                         textOutput("intout"),
                         h3("Slope:"),
                         textOutput("slopeout")
                         
                         
                     ),
                     mainPanel(
                         code("plot(mtcars$mpg,mtcars$disp,pch=16,col='blue',cex=2)"),
                         plotOutput("plot1"),
                         h2("predicted value:"),
                         h3( textOutput("pred"))
                         
                         
                     )
                 
        )
   
        ),
        tabPanel("Linear Regression on Sample",
                 br(),
                 
                 h1("Multiple Models"),
                 sidebarLayout(
                     sidebarPanel(
                         h2("Drag and Select a number of points to fit a linear model to them !"),
                         h3("Slope"),
                         textOutput("slopeOut"),
                         h3("intercept"),
                         textOutput("intOut")
                     ),
                     mainPanel(
                         h2("Data"),
                         plotOutput("plot2",brush=brushOpts(
                             id="brush1"
                         ))
                     )
                 )
                 
                 )
        ))
))
