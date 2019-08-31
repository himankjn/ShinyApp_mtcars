

library(shiny)

shinyServer(function(input, output) {
    
    dataset<-reactive({
        mtcars[sample(nrow(mtcars),input$n),]
    })
    output$xyplot<-renderPlot({
        g<-ggplot(data=dataset(),aes_string(x=input$xvar,y=input$yvar,col=input$colorvar))+geom_point()+labs(x=input$xvar,y=input$yvar)
        if(input$smooth){
        g<-g+geom_smooth()
        }
        g
    })
    
    
    model<-reactive({
        lm(data=mtcars,disp~mpg)
    })
    output$intout<-renderText({
        model()[[1]][1]
    })
    output$slopeout<-renderText({
        model()[[1]][1]
    })
    
    prediction<- reactive({
        predict(model(),newdata=data.frame(mpg=input$slider1))
    })
    output$plot1<-renderPlot({
        plot(mtcars$mpg,mtcars$disp,pch=16,col='blue',cex=2)
        abline(model(),col='red',lwd=2)
        points(input$slider1,prediction(),pch=16,cex=3)
    })
    output$pred<-renderText({prediction()})
    
    
    
    
    model2<-reactive({
        brushed_data<-brushedPoints(mtcars,input$brush1,
                                    xvar='mpg',yvar='disp')
        if(nrow(brushed_data)<2){
            return(NULL)
        }
        lm(disp~mpg,data=brushed_data)
    })
    output$slopeOut<-renderText({
        if(is.null(model2())){
            "No model found"
        }
        else{
            model2()[[1]][2]
        }
    })
    output$intOut<-renderText({
        if(is.null(model2())){
            "No model found"
        }
        else{
            model2()[[1]][1]
        }
    })
    output$plot2<-renderPlot({
        plot(mtcars$mpg,mtcars$disp,pch=16,cex=2,xlab="MPG",ylab="DISP")
        if(!is.null(model2())){
            abline(model2(),col='blue',lwd=2)
        }
    })
})
