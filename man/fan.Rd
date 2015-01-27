\name{fan}
\alias{fan}
\alias{fan0}
\title{
Fan Plot of Distributions Percentiles Over Time.
}
\description{
Visualise sequential distributions using a range of plotting styles.
}
\usage{
fan(data = NULL, data.type="simulations", style = "fan", type = "percentile",
  probs = if(type=="percentile") seq(0.01, 0.99, 0.01) else c(0.5, 0.8, 0.95), 
  start = 1, frequency = 1, anchor = NULL, anchor.time=NULL,
  fan.col = heat.colors, alpha = if (style == "spaghetti") 0.5 else 1, 
  n.fan = NULL,
  ln = if(length(probs)<10) probs else 
    probs[round(probs,2) \%in\% round(seq(0.1, 0.9, 0.1),2)],
  med.ln = if(type=="interval") TRUE else FALSE, 
  ln.col = if(style=="spaghetti") "gray" else NULL, med.col= "orange",
  rlab = ln, rpos = 4, roffset = 0.1, rcex = 0.8, rcol = NULL, 
  llab = FALSE, lpos = 2, loffset = roffset, lcex = rcex, lcol = rcol, 
  upplab = "U", lowlab = "L", medlab=if(type == "interval") "M" else NULL,
  n.spag = 30, 
  space = if(style=="boxplot") 1/frequency else 0.9/frequency, 
  add = FALSE, ylim = range(data)*0.8, ...)
fan0(data = NULL, data.type = "simulations", style = "fan", type = "percentile",
  probs = if(type=="percentile") seq(0.01, 0.99, 0.01) else c(0.5, 0.8, 0.95), 
  start = 1, frequency = 1, anchor = NULL, anchor.time=NULL,
  fan.col = heat.colors, alpha = if (style == "spaghetti") 0.5 else 1, 
  n.fan = NULL,
  ln = NULL,
  med.ln = if(type=="interval") TRUE else FALSE, 
  ln.col = if(style=="spaghetti") "gray" else NULL, med.col= "orange",
  rlab = ln, rpos = 4, roffset = 0.1, rcex = 0.8, rcol = NULL, 
  llab = FALSE, lpos = 2, loffset = roffset, lcex = rcex, lcol = rcol, 
  upplab = "U", lowlab = "L", medlab=if(type == "interval") "M" else NULL,
  n.spag = 30, 
  space = if(style=="boxplot") 1/frequency else 0.9/frequency, 
  add = TRUE, ylim = range(data)*0.8, ...)
}
\arguments{
  \item{data}{
Set of sequential simulation data, where rows represent simulation number and columns represent some form of time index. 
If \code{data.type = "values"}, data must instead be a set of quantile values by rows for a set of probabilities (which need to be provided in \code{probs} and by column for some form of time index.

Data can take multiple classes, where the contents are converted to a \code{matrix}. If the input is a \code{mts} or \code{zoo}, the time series properties will be inherted (and \code{start} and \code{frequency} arguments will be ignored).
}
  \item{data.type}{
Indicates if \code{data} are sets of pre-calculated values based for defined probabilities \code{data.type = "values"} or simulated data \code{data.type = "simulations"}. That later is the default.
}
  \item{style}{
Plot style, choose from \code{fan} (default), \code{spaghetti} \code{boxplot} or \code{boxfan}. See Examples and Details Sections for further explanation.
}
  \item{type}{
Type of percentiles to plot in \code{fan} or \code{boxfan}. Choose from, \code{percentile} (default) or \code{interval}.
}
  \item{probs}{
Probabilities related to percentiles or prediction intervals to be plotted (dependent on the \code{type} function. These values control the number of shades used in the \code{fan} or \code{boxfan}. These must be between 0 and 100 (inclusive) or 0 and 1. Percentiles greater than 50 (or 0.5), if not given, are automatically calculated as 100-\code{p}, to ensure symmetric fan. Values can be non-integers. Default to single percentile values when \code{type="percetinle"} and the 50th, 80th and 95th prediction interval when \code{type="interval"} is set.
}
  \item{start}{
The time of the first distribution in \code{sims}. Similar to use in \code{\link{ts}}.
}
  \item{frequency}{
The number of distribution in \code{sims} per unit of time in \code{sims}. Similar to use in \code{\link{ts}}.
}
  \item{anchor}{
Optional data value to anchor a forecast fan on. Typically this will be the last observation of the observed data series.
}
  \item{anchor.time}{
Optional data value for the time of the anchor. Useful for irregular time series.
}
  \item{fan.col}{
Palette of colours used in the \code{fan} or \code{boxfan}.
}
  \item{n.fan}{
The number of colours to use in the fan.
}
  \item{alpha}{
Factor modifying the opacity alpha; typically in [0,1].
}
  \item{ln}{
Vector of number to plot contour lines on-top \code{fan} or \code{boxfan}. Must correspond to calculated percentiles in \code{probs}. By default for \code{fan} takes either every percentile or prediction interval given in the \code{probs} argument (if less then 10) or, when there are more than 10 \code{probs} passed, the either every decile or every prediction interval that are a multiple of 10 and given in \code{probs}. No lines plotted by default for \code{fan0}
}
  \item{med.ln}{
Add a median line to fan. Might be of particular use if \code{type="interval"}. Only works when \code{data.type = "simulations"} and one of \code{fan}, \code{boxfan} or \code{spaghetti} styles.
}
  \item{ln.col}{
Line colour to be imposed on top of the fan. By default takes the darkest colour from \code{fan.col} argument, unless \code{style="spaghetti"}
}
  \item{med.col}{
Median Line colour. By default this is set to the first colour in \code{fan.col}. Users might wish to change to highlight the median.
}
  \item{rlab}{
Vector of labels at the end (right) of corresponding percentiles or prediction intervals of the \code{fan} or \code{boxfan}. Must be in calculated in the \code{probs} argument. By default plotted alongside values provided to the \code{ln} argument.
}
  \item{rpos}{
Position of right labels for the \code{fan} or \code{boxfan}. See \code{\link{text}}.
}
  \item{roffset}{
Offset of right labels for the \code{fan} or \code{boxfan}. See \code{\link{text}}.
}
  \item{rcex}{
Text size of right labels for the \code{fan} or \code{boxfan}. See \code{\link{text}}.
}
  \item{rcol}{
Colour of text for right labels for the \code{fan} or \code{boxfan}. See \code{\link{text}}.
}
  \item{llab}{
Can take either 1) a \code{TRUE} or \code{FALSE} value to plot label at the start (right) of the  corresponding percentiles or prediction intervals given in \code{rlab}, default is \code{FALSE} or 2) a original vector of percentiles or prediction intervals. Must be in calculated in the \code{probs} argument. Only works for \code{fan} or \code{boxfan} styles.
}
  \item{lpos}{
Position of left labels for the \code{fan} or \code{boxfan}. See \code{\link{text}}.
}
  \item{loffset}{
Offset of left labels for the \code{fan} or \code{boxfan}.By default takes the same value as \code{roffset}. See \code{\link{text}}.
}
  \item{lcex}{
Text size of left labels for the \code{fan} or \code{boxfan}. By default takes the same value as \code{rex}. See \code{\link{text}}.
}
  \item{lcol}{
Colour of text for left labels for the \code{fan} or \code{boxfan}.  By default takes the same value as \code{rcol}. See \code{\link{text}}.
}
  \item{upplab}{
Prefix character string for upper labels to be used for the \code{fan} or \code{boxfan} when \code{type="interval"}.
}
  \item{lowlab}{
Prefix character string for lower labels to be used for the \code{fan} or \code{boxfan} when \code{type="interval"} .
}
  \item{medlab}{
Character string for median label.
}
  \item{n.spag}{
Number of simulations to plot in the \code{spaghetti} plot.
}
  \item{space}{
Space between boxes in the \code{boxfan} plot.
}
  \item{add}{
Add to active plot. By default \code{FALSE} for \code{fan} and \code{TRUE} for \code{fan0}.
}
  \item{ylim}{
Passed to \code{plot} when \code{add = TRUE}.
}
  \item{\dots}{
Additional arguments passed to \code{\link{boxplot}} for \code{fan} and to \code{\link{plot}} for \code{fan0}.
}
}
\details{
Visualise sequential distributions using a range of plotting styles. Sequential distribution data can be input as either simulations or pre-computed values over time (columns). For the later, the user should declare input data as percentiles by setting \code{data.type = "values"}. Plots are added to existing graphic devices. Users can choose from four different styles.

The \code{fan} and \code{boxfan} style plot distributions based on used-defined shading scheme, controlled by the \code{fan.col} argument. Additional lines and text are added to illustrate major contours on the probability distribution. Lines and labels can be suppressed by adding \code{ln = NULL} and \code{rlab = NULL}. Labels to the left of the fan can also be specified using the \code{llab} argument. Colours are by default taken from the \code{\link{heat.colors}} palette. Alternatives can be specified using \code{fan.col} (see the example below). The joining of a forecast fan to data is controlled be the anchor argument.

The \code{spaghetti} style, plots random draws (when \code{data.type = "simulations"} is set) along the sequence of distributions. The number of draws is controlled by the \code{n.spag} argument. The transparency of the lines is controlled by \code{alpha}.

The \code{boxplot} style, adds a box plot for simulated data at the appropriate location, according to the \code{start} and \code{frquency} arguments. Gaps between box plots are controlled by \code{space} argument. Additional arguments are passed to \code{\link{boxplot}}.
}
\value{
See details
}
\author{
Guy J. Abel
}
\examples{
##
## Basic Fan: fan0()
##
fan0(th.mcmc)

##
## Basic Fan: fan()
##
# empty plot
plot(NULL, xlim = c(1, 945), ylim = range(th.mcmc)*0.85)

# add fan
fan(th.mcmc)

##
## 20 or so examples of fan charts and
## spaghetti plots based on the th.mcmc object
##
## Make sure you have zoo, tsbugs, RColorBrewer and 
## colorspace packages installed
##
\dontrun{
demo("sv_fan", "fanplot")
}

##
## Fans for forecasted values
##
\dontrun{
#create time series
net <- ts(ips$net, start=1975)

# fit model
library("forecast")
m <- auto.arima(net)

# plot in forecast package (limited customisation possible)
plot(forecast(m, h=5))

# another plot in forecast (with some customisation, no
# labels or anchoring possible at the moment)
plot(forecast(m, h=5, level=c(50,80,95)), 
     shadecols=rev(heat.colors(3)))

# simulate future values
mm <- matrix(NA, nrow=1000, ncol=5)
for(i in 1:1000)
  mm[i,] <- simulate(m, nsim=5)

# interval fan chart
plot(net, xlim=c(1975,2020), ylim=c(-100,300))
fan(mm, type="interval", start=2013)

# anchor fan chart
plot(net, xlim=c(1975,2020), ylim=c(-100,300))
fan(mm, type="interval", start=2013, 
    anchor=net[time(net)==2012])

# anchor spaghetti plot with underlying fan chart
plot(net, xlim=c(1975,2020), ylim=c(-100,300))
fan(mm, type="interval", start=2013, 
    anchor=net[time(net)==2012], alpha=0, ln.col="orange")
fan(mm, type="interval", start=2013, 
    anchor=net[time(net)==2012], alpha=0.5, style="spaghetti")
}

##
## Box Plots
##
# sample every 21st day of theta_t
th.mcmc21 <- th.mcmc[, seq(1, 945, 21)]
plot(NULL, xlim = c(1, 945), ylim = range(th.mcmc21))
fan(th.mcmc21, style = "boxplot", frequency = 1/21)

# additional arguments for boxplot
plot(NULL, xlim = c(1, 945), ylim = range(th.mcmc21))
fan(th.mcmc21, style = "boxplot", frequency = 1/21, 
 outline = FALSE, col = "red", notch = TRUE)

##
## Fan Boxes
##
plot(NULL, xlim = c(1, 945), ylim = range(th.mcmc21))
fan(th.mcmc21, style = "boxfan", type = "interval", frequency = 1/21)

# more space between boxes
plot(NULL, xlim = c(1, 945), ylim = range(th.mcmc21))
fan(th.mcmc21, style = "boxfan", type = "interval", 
 frequency = 1/21, space = 10)

# overlay spaghetti
fan(th.mcmc21, style = "spaghetti", 
 frequency = 1/21, n.spag = 50, ln.col = "red", alpha=0.2) 
}
\keyword{ aplot }
