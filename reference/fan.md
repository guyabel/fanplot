# Fan Plot of Distribution Percentiles Over Time

Visualise sequential distributions using a range of plotting styles.

## Usage

``` r
fan(
  data = NULL,
  data.type = "simulations",
  style = "fan",
  type = "percentile",
  probs = if (type == "percentile") seq(0.01, 0.99, 0.01) else c(0.5, 0.8, 0.95),
  start = 1,
  frequency = 1,
  anchor = NULL,
  anchor.time = NULL,
  fan.col = grDevices::heat.colors,
  alpha = if (style == "spaghetti") 0.5 else 1,
  n.fan = NULL,
  ln = if (length(probs) < 10) probs else probs[round(probs, 2) %in% round(seq(0.1,
    0.9, 0.1), 2)],
  ln.col = if (style == "spaghetti") "gray" else NULL,
  med.ln = if (type == "interval") TRUE else FALSE,
  med.col = "orange",
  rlab = ln,
  rpos = 4,
  roffset = 0.1,
  rcex = 0.8,
  rcol = NULL,
  llab = FALSE,
  lpos = 2,
  loffset = roffset,
  lcex = rcex,
  lcol = rcol,
  upplab = "U",
  lowlab = "L",
  medlab = if (type == "interval") "M" else NULL,
  n.spag = 30,
  space = if (style == "boxplot") 1/frequency else 0.9/frequency,
  add = FALSE,
  ylim = range(data) * 0.8,
  ...
)
```

## Arguments

- data:

  Set of sequential simulation data, where rows represent simulation
  number and columns represent some form of time index. If
  `data.type = "values"`, data must instead be a set of quantile values
  by rows for a set of probabilities (which need to be provided in
  `probs`) and by column for some form of time index. Data can take
  multiple classes, where the contents are converted to a `matrix`. If
  the input is a `mts` or `zoo`, the time series properties will be
  inherited (and `start` and `frequency` arguments will be ignored).

- data.type:

  Indicates if `data` are sets of pre-calculated values for defined
  probabilities (`"values"`) or simulated data (`"simulations"`).
  Default is `"simulations"`.

- style:

  Plot style, choose from `"fan"` (default), `"spaghetti"`, `"boxplot"`
  or `"boxfan"`.

- type:

  Type of percentiles to plot in `fan` or `boxfan`. Choose from
  `"percentile"` (default) or `"interval"`.

- probs:

  Probabilities related to percentiles or prediction intervals to be
  plotted (dependent on the `type` argument). Must be between 0 and 100
  (inclusive) or 0 and 1. Percentiles greater than 50 (or 0.5), if not
  given, are automatically calculated as 100 - `p`, to ensure symmetric
  fan. Defaults to single percentile values when `type = "percentile"`
  and the 50th, 80th and 95th prediction interval when
  `type = "interval"`.

- start:

  The time of the first distribution in `sims`. Similar to use in
  [`ts`](https://rdrr.io/r/stats/ts.html).

- frequency:

  The number of distributions in `sims` per unit of time. Similar to use
  in [`ts`](https://rdrr.io/r/stats/ts.html).

- anchor:

  Optional data value to anchor a forecast fan on. Typically the last
  observation of the observed series.

- anchor.time:

  Optional time value for the anchor. Useful for irregular time series.

- fan.col:

  Palette of colours used in the `fan` or `boxfan`.

- alpha:

  Factor modifying the opacity alpha; typically in \[0,1\].

- n.fan:

  Number of colours to use in the fan.

- ln:

  Vector of numbers to plot contour lines on top of `fan` or `boxfan`.
  Must correspond to calculated percentiles in `probs`.

- ln.col:

  Line colour imposed on top of the fan. Defaults to darkest colour from
  `fan.col`, unless `style = "spaghetti"`.

- med.ln:

  Logical; add a median line to fan. Useful if `type = "interval"`.

- med.col:

  Median line colour. Defaults to first colour in `fan.col`.

- rlab:

  Vector of labels at the end (right) of corresponding percentiles or
  prediction intervals.

- rpos:

  Position of right labels. See
  [`text`](https://rdrr.io/r/graphics/text.html).

- roffset:

  Offset of right labels. See
  [`text`](https://rdrr.io/r/graphics/text.html).

- rcex:

  Text size of right labels. See
  [`text`](https://rdrr.io/r/graphics/text.html).

- rcol:

  Colour of text for right labels. See
  [`text`](https://rdrr.io/r/graphics/text.html).

- llab:

  Either logical (TRUE/FALSE) to plot labels at the start (left) of
  percentiles, or a vector of percentiles. Only works for `fan` or
  `boxfan`.

- lpos:

  Position of left labels. See
  [`text`](https://rdrr.io/r/graphics/text.html).

- loffset:

  Offset of left labels. Defaults to `roffset`.

- lcex:

  Text size of left labels. Defaults to `rcex`.

- lcol:

  Colour of text for left labels. Defaults to `rcol`.

- upplab:

  Prefix string for upper labels when `type = "interval"`.

- lowlab:

  Prefix string for lower labels when `type = "interval"`.

- medlab:

  Character string for median label.

- n.spag:

  Number of simulations to plot in the `spaghetti` style.

- space:

  Space between boxes in the `boxfan` plot.

- add:

  Logical; add to active plot. Defaults to `FALSE` for `fan`, `TRUE` for
  `fan0`.

- ylim:

  Passed to `plot` when `add = TRUE`.

- ...:

  Additional arguments passed to
  [`boxplot`](https://rdrr.io/r/graphics/boxplot.html) for `fan` and to
  [`plot`](https://rdrr.io/r/graphics/plot.default.html) for `fan0`.

## Value

See details.

## Details

Sequential distribution data can be input as either simulations or
pre-computed values over time (columns). For the latter, declare input
data as percentiles by setting `data.type = "values"`. Users can choose
from four styles:

- `fan`, `boxfan`: shaded distributions with optional contour lines and
  labels.

- `spaghetti`: random draws plotted along the sequence of distributions.

- `boxplot`: box plots for simulated data at appropriate locations.

## References

Abel, G. J. (2015). fanplot: An R Package for visualising sequential
distributions. *The R Journal*, 7(2), 15–23.

## Author

Guy J. Abel

## Examples

``` r
## Basic Fan: fan0()

##
## 20 or so examples of fan charts and
## spaghetti plots based on the th.mcmc object
##
## Make sure you have zoo, tsbugs, RColorBrewer and 
## colorspace packages installed
##
if (FALSE) { # \dontrun{
demo("sv_fan", "fanplot")
} # }

##
## Fans for forecasted values
##
if (FALSE) { # \dontrun{
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
} # }

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


```
