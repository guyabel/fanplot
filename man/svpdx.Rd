\name{svpdx}
\alias{svpdx}
\docType{data}
\title{
Pound-Dollar Exchange Rate Data
}
\description{
Pound-Dollar exchange rate data from 2nd October 1981 to 28th June 1985.
}
\usage{data(svpdx)}
\format{
  A data frame with 945 observations on the following 2 variables.
  \describe{
    \item{\code{date}}{Date of observation.}
    \item{\code{pdx}}{Logarithm of returns for Pound-Dollar exchange.}
  }
}
\details{
Raw data on log returns.
}
\source{
http://www.econ.vu.nl/koopman/sv/svpdx.dat
}
\references{
Meyer, R. and J. Yu (2002). BUGS for a Bayesian analysis of stochastic volatility models. \emph{Econometrics Journal} 3 (2), 198--215.
}
\examples{
data(svpdx)

# plot
plot(svpdx$pdx, type = "l", xaxt = "n", xlab = "Time", ylab = "Return")

# add x-axis
svpdx$rdate<-format(svpdx$date, format = "\%b \%Y")
mth <- unique(svpdx$rdate)
qtr <- mth[seq(1,length(mth),3)]
axis(1, at = match(qtr, svpdx$rdate), labels = qtr, cex.axis = 0.75)
axis(1, at = match(mth, svpdx$rdate), labels = FALSE, tcl = -0.2)
}
\keyword{datasets}
