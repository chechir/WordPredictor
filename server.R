library(shiny)
library(DT)
#library(UsingR)
#data(fat)


#fit<-lm(body.fat~age+weight+height+neck+abdomen+thigh+forearm+wrist, data=fat)
#fit2<-lm(body.fat.siri~age+weight+height+neck+abdomen+thigh+forearm+wrist, data=fat)

shinyServer(  
  function(input, output) {    
    
    output$predtext <- renderText({
        input$goButton
        isolate(input$text1)
    })
    output$pred <- renderTable({
        input$goButton
        isolate(predictKN(input$text1, input$n, input$reorder))
    })

  }
)


