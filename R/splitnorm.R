#' The Split Normal Distribution (or Two-Piece Normal Distribution)
#'
#' Density, distribution function, quantile function and random generation
#' for the split normal distribution.
#'
#' @param x Vector of quantiles (for dsplitnorm, psplitnorm).
#' @param p Vector of probabilities (for qsplitnorm).
#' @param n Number of observations required (for rsplitnorm).
#' @param mode Vector of modes.
#' @param sd Vector of uncertainty indicators.
#' @param skew Vector of inverse skewness indicators. Must range between -1 and 1.
#' @param sd1 Vector of standard deviations for left-hand side. \code{NULL} by default.
#' @param sd2 Vector of standard deviations for right-hand side. \code{NULL} by default.
#'
#' @details
#' If \code{mode}, \code{sd} or \code{skew} are not specified they assume the default 
#' values of 0, 1 and 0, respectively. This results in identical values as those 
#' obtained from a normal distribution.
#'
#' The probability density function is:
#' \deqn{f(x; \mu, \sigma_1, \sigma_2) = \frac{\sqrt{2}}{\sqrt{\pi} (\sigma_1 + \sigma_2)} e^{-\frac{1}{2\sigma_1^2}(x - \mu)^2}}
#' for \eqn{-\infty < x < \mu}, and
#' \deqn{f(x; \mu, \sigma_1, \sigma_2) = \frac{\sqrt{2}}{\sqrt{\pi} (\sigma_1 + \sigma_2)} e^{-\frac{1}{2\sigma_2^2}(x - \mu)^2}}
#' for \eqn{\mu < x < \infty}.
#' 
#' If not specified (via \code{sd1} and \code{sd2}), \eqn{\sigma_1} and \eqn{\sigma_2} are derived as:
#' \deqn{\sigma_1 = \sigma / \sqrt{1 - \gamma}}
#' \deqn{\sigma_2 = \sigma / \sqrt{1 + \gamma}}
#' where \eqn{\sigma} is the overall uncertainty indicator \code{sd} and \eqn{\gamma} 
#' is the inverse skewness indicator \code{skew}.

#' @return
#' \code{dsplitnorm} gives the density, \code{psplitnorm} gives the distribution function,
#' \code{qsplitnorm} gives the quantile function, and \code{rsplitnorm} generates random deviates.
#'
#' @rdname dsplitnorm
#' @examples
#' x <- seq(-5, 5, length = 110)
#' plot(x, dsplitnorm(x), type = "l")
#'
#' # compare to normal density
#' lines(x, dnorm(x), lty = 2, col = "red", lwd = 5)
#'
#' # add positive skew
#' lines(x, dsplitnorm(x, mode = 0, sd = 1, skew = 0.8))
#'
#' # add negative skew
#' lines(x, dsplitnorm(x, mode = 0, sd = 1, skew = -0.5))
#'
#' # add left and right hand sd
#' lines(x, dsplitnorm(x, mode = 0, sd1 = 1, sd2 = 2), col = "blue")
#'
#' # psplitnorm
#' x <- seq(-5, 5, length = 100)
#' plot(x, pnorm(x), type = "l")
#' lines(x, psplitnorm(x, skew = -0.9), col = "red")
#'
#' # qsplitnorm
#' x <- seq(0, 1, length = 100)
#' plot(qnorm(x), type = "l", x)
#' lines(qsplitnorm(x), x, lty = 2, col = "blue")
#' lines(qsplitnorm(x, skew = -0.3), x, col = "red")
#'
#' # rsplitnorm
#' hist(rsplitnorm(n = 10000, mode = 1, sd = 1, skew = 0.9), 100)
#' @export
dsplitnorm <- function(x, mode = 0, sd = 1, skew = 0, sd1 = NULL, sd2 = NULL) {
    n <- max(length(x),length(mode),length(sd),length(skew),length(sd1),length(sd2))
    if(length(x)<n)
      x[1:n]<-x
    if(length(mode)<n)
      mode[1:n]<-mode
    if(length(sd)<n)
      sd[1:n]<-sd
    if(length(skew)<n)
      skew[1:n]<-skew
    if(length(sd1)<n)
      sd1[1:n]<-sd1
    if(length(sd2)<n)
      sd2[1:n]<-sd2
    var0 <- sd^2
    if (!is.null(sd1)) 
      var1 <- sd1^2
    if (!is.null(sd2)) 
      var2 <- sd2^2
    if (sum(is.null(sd1), is.null(sd2)) == 1) 
      stop("give either sd of both sides (sd1 and sd2) or neither (sd only)")
    if (is.null(sd1) & is.null(sd2)) {
      var1 <- var0/(1 + skew)
      var2 <- var0/(1 - skew)
      sd1 <- sqrt(var1)
      sd2 <- sqrt(var2)
    }
    if (any(findInterval(skew, c(-1,1), rightmost.closed=TRUE)!=1) )
      stop("skew must be between -1 and 1")
    f <- rep(NA, n)
    c <- sqrt(2/pi)/(sd1 + sd2)
    x1 <- x <= mode
    x2 <- x > mode
    f[x1] <- c[x1] * exp((-(x[x1] - mode[x1])^2)/(2 * var1[x1]))
    f[x2] <- c[x2] * exp((-(x[x2] - mode[x2])^2)/(2 * var2[x2]))
    return(f)
}

#' @rdname dsplitnorm
#' @export
psplitnorm <-
  function(x, mode = 0, sd = 1, skew = 0, sd1 = NULL, sd2 = NULL) {
    n <- max(length(x),length(mode),length(sd),length(skew),length(sd1),length(sd2))
    if(length(x)<n)
      x[1:n]<-x
    if(length(mode)<n)
      mode[1:n]<-mode
    if(length(sd)<n)
      sd[1:n]<-sd
    if(length(skew)<n)
      skew[1:n]<-skew
    if(length(sd1)<n)
      sd1[1:n]<-sd1
    if(length(sd2)<n)
      sd2[1:n]<-sd2
    var0 <- sd^2
    if (!is.null(sd1)) 
      var1 <- sd1^2
    if (!is.null(sd2)) 
      var2 <- sd2^2
    if (sum(is.null(sd1), is.null(sd2)) == 1) 
      stop("give either sd of both sides (sd1 and sd2) or neither (sd only)")
    if (is.null(sd1) & is.null(sd2)) {
      var1 <- var0/(1 + skew)
      var2 <- var0/(1 - skew)
      sd1 <- sqrt(var1)
      sd2 <- sqrt(var2)
    }
    if (any(findInterval(skew, c(-1,1), rightmost.closed=TRUE)!=1) )
      stop("skew must be between -1 and 1")
    f <- rep(NA, n)
    c <- sqrt(2/pi)/(sd1 + sd2)
    k <- f 
    k[] <- x #change name of x to match formula
    k1 <- k <= mode
    k2 <- k > mode
    f[k1] <- (c[k1] * sqrt(2 * pi) * sd1[k1] * stats::pnorm((k[k1] - mode[k1])/sd1[k1]))
    f[k2] <- (1 - c[k2] * sqrt(2 * pi) * sd2[k2] * (1 - stats::pnorm((k[k2] - mode[k2])/sd2[k2])))
    return(f)
  }

#' @rdname dsplitnorm
#' @export
qsplitnorm <-
  function(p, mode = 0, sd = 1, skew = 0, sd1 = NULL, sd2 = NULL) {
    n <- max(length(p),length(mode),length(sd),length(skew),length(sd1),length(sd2))
    if(length(p)<n)
      p[1:n]<-p
    if(length(mode)<n)
      mode[1:n]<-mode
    if(length(sd)<n)
      sd[1:n]<-sd
    if(length(skew)<n)
      skew[1:n]<-skew
    if(length(sd1)<n)
      sd1[1:n]<-sd1
    if(length(sd2)<n)
      sd2[1:n]<-sd2
    var0 <- sd^2
    if (!is.null(sd1)) 
      var1 <- sd1^2
    if (!is.null(sd2)) 
      var2 <- sd2^2
    if (sum(is.null(sd1), is.null(sd2)) == 1) 
      stop("give either sd of both sides (sd1 and sd2) or neither (sd only)")
    if (is.null(sd1) & is.null(sd2)) {
      var1 <- var0/(1 + skew)
      var2 <- var0/(1 - skew)
      sd1 <- sqrt(var1)
      sd2 <- sqrt(var2)
    }
    if (any(findInterval(skew, c(-1,1), rightmost.closed=TRUE)!=1) )
      stop("skew must be between -1 and 1")
    f <- rep(NA, n)
    c <- sqrt(2/pi)/(sd1 + sd2)
    #change name of p to match formula
    alpha <- p
    #p in formula is from psplitnorm. replace.
    p <- psplitnorm(mode, mode = mode, sd1 = sd1, sd2 = sd2) 
    alpha1 <- alpha <= p
    alpha2 <- alpha > p
    f[alpha1] <- (mode[alpha1] + sd1[alpha1] * stats::qnorm( alpha[alpha1]/(c[alpha1] * sqrt(2 * pi) * sd1[alpha1])))
    f[alpha2] <- (mode[alpha2] + sd2[alpha2] * stats::qnorm((alpha[alpha2]+ c[alpha2] * sqrt(2 * pi) * sd2[alpha2] - 1)/(c[alpha2] * sqrt(2 * pi) * sd2[alpha2])))
    f
  }

#' @rdname dsplitnorm
#' @export
rsplitnorm <-
  function(n, mode = 0, sd = 1, skew = 0, sd1 = NULL, sd2 = NULL) {
    n <- max(n,length(mode),length(sd),length(skew),length(sd1),length(sd2))
    if(length(mode)<n)
      mode[1:n]<-mode
    if(length(sd)<n)
      sd[1:n]<-sd
    if(length(skew)<n)
      skew[1:n]<-skew
    if(length(sd1)<n)
      sd1[1:n]<-sd1
    if(length(sd2)<n)
      sd2[1:n]<-sd2
    var0 <- sd^2
    if (!is.null(sd1)) 
      var1 <- sd1^2
    if (!is.null(sd2)) 
      var2 <- sd2^2
    if (sum(is.null(sd1), is.null(sd2)) == 1) 
      stop("give either sd of both sides (sd1 and sd2) or neither (sd only)")
    if (is.null(sd1) & is.null(sd2)) {
      var1 <- var0/(1 + skew)
      var2 <- var0/(1 - skew)
      sd1 <- sqrt(var1)
      sd2 <- sqrt(var2)
    }
    if (any(findInterval(skew, c(-1,1), rightmost.closed=TRUE)!=1) )
      stop("skew must be between -1 and 1")
    u <- stats::runif(n)
    f <- qsplitnorm(u, mode = mode, sd = sd, skew = skew, sd1 = sd1, sd2 = sd2)
    f
  }

