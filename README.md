
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fanplot

<!-- badges: start -->

[![Lifecycle:
superseded](https://img.shields.io/badge/lifecycle-superseded-blue.svg)](https://lifecycle.r-lib.org/articles/stages.html#superseded)
[![CRAN
status](https://www.r-pkg.org/badges/version/fanplot)](https://CRAN.R-project.org/package=fanplot)
<!-- badges: end -->

<img src='https://raw.githubusercontent.com/guyabel/fanplot/master/hex/logo_transp.png' align="right" height="180" style="padding-left: 20px; padding-bottom: 20px;" />

Visualise sequential distributions using a range of plotting styles.
Sequential distribution data can be input as either simulations or
values corresponding to percentiles over time. Plots are added to
existing graphic devices using the fan function. Users can choose from
four different styles, including fan chart type plots, where a set of
coloured polygon, with shadings corresponding to the percentile values
are layered to represent different uncertainty levels.

## ggplot

All plots are using base R. Jason Hilton has a
[ggfan](https://github.com/jasonhilton/ggfan) package which is great for
creating fan charts in ggplot2.

## Installation

You can install the released version of fanplot from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("fanplot")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("guyabel/fanplot")
```

## Example

``` r
library(fanplot)

# empty plot
plot(NULL, xlim = c(1, 945), ylim = range(th.mcmc)*0.85, ylab = "Volatility")

# add fan
fan(th.mcmc)
```

## Article

Read more about the fanplot package in the *R Journal*
[article](http://journal.r-project.org/archive/2015-1/abel.pdf)

## Citation

Abel, G. J. (2015). fanplot: An R package for visualising sequential
distributions. *R Journal*, 7(1), 15–23.
