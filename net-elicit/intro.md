
## Eliciting future probabiltiy distributions

Eliciting from experts the potential future distributions is not easy. It typically involves a series of questions without much visual guidance to how the answers provide translate into the implied future distributions. 

Interactive apps, such as the one below, can provide a more visual approach to elicitation. Built using shiny, the parameters from split normal distributions (using [`qsplitnorm`](http://guyabel.github.io/fanplot/reference/dsplitnorm.html) in fanplot) can be converted into a fan chart (using [`fan`](http://guyabel.github.io/fanplot/reference/fan.html) in fanplot)

The underlying parameters of a split normal distribution can potentially be used to incorporate expert opinions in a Bayesian modelling framework. The values from the central prediction, uncertainty and skewness in the final prediction year match to the parameters of a split normal distribution. Parameters for intervening years are obtained via a linear interpolations. 


## Shiny app to elicit expert based forecasts of UK net migration
