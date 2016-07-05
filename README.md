# Predicting the next word using n-grams
Matias Thayer  

<small> 
Final Project.
Johns Hopkins University.   
Data Science Specialization. 
</small>


###Predicting the next word 

- The predictions are given by the Kneser Ney smoothing probability distribution. 
- This is a public app, and you can try it in this Shiny app: 
    - https://chechir.shinyapps.io/Wordict/
- You only need to input any text and opptionaly you can set some options such as:
    - Number of words to return
    - If you want the results ordered by the Keser Ney algorithm probability
- The app takes around 12 seconds to load
- A preliminar exploratory data analysis can be found [Here](http://rpubs.com/chechir/predictNextWord)


###Why Kneser Ney Smoothing algorithm?

- It accounts for unseen n-grams, and also includes clever ideas such as P continuation. 
- Also has an elegant intuition and good performance 
- I based my implementation on the work of Daniel Jurafsky & James H. Martin: [Here](https://lagunita.stanford.edu/c4x/Engineering/CS-224N/asset/slp4.pdf)
Formula for bigrams: <small> $$P_{(KN)}(w_i|w_{i-1}) = \frac{max(c(w_{-1}, w_{1}) - 
\delta, 0)}{\sum_{w'}{c(w_{i-1}, w')}} + \lambda_{w_{i-1}}P_{cont}(w_i) $$
Where lambda is $$\lambda_{w-1}=\frac{d}{c(w_{i-1})}$$</small>


###Performance of the model 

- 15% accuracy to the first predicted word
- 30% accuracy to the 5 first words estimated
- Measured against 100 text messages
    - Randomly selected from tweets, blogs and news
    - Excluded from the tran set

###Implementation 

- The app was trained using the [HC corpora](http://www.corpora.heliohost.org/)
    - It uses tweets, blog entries and news (only from English)
- Some data was drop in order to make the app more responsive. 
    - I had to sacrifice some accuracy
- The n-grams were calculated using quanteda
- The counts and probability were calculated using the dplyr library 

###Posible next steps

- Improve accuracy by adding semantic to the algorithm 
- Implement in a mobile environment
- Narrow the train corpus for a particual context.



