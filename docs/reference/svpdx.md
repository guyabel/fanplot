# Pound–Dollar Exchange Rate Data

Pound–Dollar exchange rate data from 2 October 1981 to 28 June 1985.

## Usage

``` r
data(svpdx)
```

## Format

A data frame with 945 observations on the following 2 variables:

- date:

  Date of observation.

- pdx:

  Logarithm of returns for Pound–Dollar exchange.

## Source

<http://www.econ.vu.nl/koopman/sv/svpdx.dat>

## Details

Raw data on log returns.

## References

Meyer, R. and J. Yu (2002). BUGS for a Bayesian analysis of stochastic
volatility models. *Econometrics Journal*, 3(2), 198–215.

## Examples

``` r
data(svpdx)

# plot
plot(svpdx$pdx, type = "l", xaxt = "n",
     xlab = "Time", ylab = "Return")

# add x-axis
svpdx$rdate <- format(svpdx$date, format = "%b %Y")
mth <- unique(svpdx$rdate)
qtr <- mth[seq(1, length(mth), 3)]
axis(1, at = match(qtr, svpdx$rdate), labels = qtr, cex.axis = 0.75)
axis(1, at = match(mth, svpdx$rdate), labels = FALSE, tcl = -0.2)

```
