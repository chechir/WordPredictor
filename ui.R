library(shiny)
library(DT)

shinyUI(
  navbarPage(
    "NLP",
    id = "nav",
    tabPanel("Pedicting the next word",
      sidebarPanel(
        textInput(inputId="text1", label = "Text"),
        sliderInput('n', 'Number of predictions',value = 5, min = 1, max = 20, step = 1),
        checkboxInput("reorder", "Reorder by Keyser-Ney probability?", FALSE), 
        actionButton("goButton", "Go!")
      ), 
      
      mainPanel(  
        # fluidRow(column(3,
        #                 numericInput(
        #                   "minScore",
        #                   "Min score",
        #                   min = 0,
        #                   max = 7000,
        #                   value = 0,
        #                   step = 500
        #                 )
        # ),
        # column(3, numericInput("maxScore",
        #                        "Max score",
        #                        min = 0,
        #                        max = 7000,
        #                        value = 7000,
        #                        step = 500
        # )
        # )),
        # hr(),
        # DT::dataTableOutput("predtable"),
        HTML('<hr style="color: purple;">'),
        # p("  "),
        p("Your next word prediction for:"),
        htmlOutput('predtext'),
        htmlOutput('pred') ,
        # HTML('<hr style="color: purple;">'),
        # 
        # HTML('<p><font size=3, color="blue">
        #      You just need to adjust your body parameters using the sliders in the left panel </font></p>'),
        # HTML('<p>This prediction was made using two multivariate linear regressions (on for each type of fat percentage calculation). </p>'),
        # HTML('<li>fit<-lm(body.fat~age+weight+height+neck+abdomen+thigh+forearm+wrist, data=fat)'),
        # tableOutput('coef'),
        # p("Adjusted R Square:"),
        # textOutput('adjR'),
        # HTML('<li>fit2<-lm(body.fat.siri~age+weight+height+neck+abdomen+thigh+forearm+wrist, data=fat)'),
        # tableOutput('coef2'),
        # p("Adjusted R Square:"),
        # textOutput('adjR2'),
        # HTML('<br/>'),
        # HTML('<hr style="color: purple;">'),
        # HTML('<p>You can see more datils of this work in <a href="http://rpubs.com/chechir/predictFat", target="_new")> HERE </a></p>'),
        # 
        # HTML('<p>DISCLAIMER: This application only gives an estimation and does not replace a visit to your doctor!</p>'),
        
        HTML('<p>Author: Matias Thayer</p>'),
        HTML('<p>More apps like this one: <a href="http://trysomeapps.blogspot.cl/"> http://trysomeapps.blogspot.cl </a> </p>'),
        
        HTML('<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
             <!-- predictFat_add -->
             <ins class="adsbygoogle"
             style="display:block"
             data-ad-client="ca-pub-6171899004969356"
             data-ad-slot="7252872023"
             data-ad-format="auto"></ins>
             <script>
             (adsbygoogle = window.adsbygoogle || []).push({});
             </script>')
        
        )
    ),
    tabPanel(
      "More...",
        HTML(
          '<p>More data science experiments in here: <a href="http://trysomeapps.blogspot.cl/"> http://trysomeapps.blogspot.cl </a> </p>'
        ),
        HTML(
          '<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
          <!-- predictFat_add -->
          <ins class="adsbygoogle"
          style="display:block"
          data-ad-client="ca-pub-6171899004969356"
          data-ad-slot="7252872023"
          data-ad-format="auto"></ins>
          <script>
          (adsbygoogle = window.adsbygoogle || []).push({});
          </script>')
      )
  )
)
