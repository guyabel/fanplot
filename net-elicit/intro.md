
## Eliciting future probabiltiy distributions

Eliciting potential future distributions is typically undertaken in order to combine expert opinions and past data. It usually involves a series of questions, without any visual guidance to how the answers provided translate into the implied future distributions. I have been on both sides of the process; helping design and convert questionnaires answers into model inputs and responding to questions as an expert myself. From both standpoints there are hidden layers of uncertainty in the elicitation exercises, where those asking questions are making assumptions about the respondents implied distributions and the respondent is themselves are unsure of how the answers will be incorporated into a model.

Interactive apps, such as the one below, can provide a more visual approach to elicitation. Built using [shiny](https://shiny.rstudio.com/), the parameters from split normal distributions (using [`qsplitnorm`](http://guyabel.github.io/fanplot/reference/dsplitnorm.html) in fanplot) can be converted into a fan chart (using [`fan`](http://guyabel.github.io/fanplot/reference/fan.html) in fanplot)

The underlying parameters of a split normal distribution can potentially be used to incorporate expert opinions in a Bayesian modelling framework. The values from the central prediction, uncertainty and skewness in the final prediction year match to the parameters of a split normal distribution. Parameters for intervening years are obtained via a linear interpolations. Change points can be added, with a new set of parameters for intervening periods. 


## Shiny app to elicit expert based forecasts of UK net migration
