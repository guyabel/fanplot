#' ONS International Passenger Survey Long-Term International Migration 1975–2012
#'
#' Immigration, emigration and net migration flow counts (and their confidence intervals)
#' for the UK from the International Passenger Survey (IPS) conducted by the Office of
#' National Statistics. Data formatted from the 2012 release of the Long-Term International
#' Migration Statistics.
#'
#' @docType data
#' @usage data(ips)
#'
#' @format A data frame with 38 observations on the following 7 variables:
#' \describe{
#'   \item{year}{Numeric vector; year of observation.}
#'   \item{imm}{Numeric vector; immigration flow counts.}
#'   \item{imm.ci}{Numeric vector; confidence intervals for immigration.}
#'   \item{emi}{Numeric vector; emigration flow counts.}
#'   \item{emi.ci}{Numeric vector; confidence intervals for emigration.}
#'   \item{net}{Numeric vector; net migration flow counts.}
#'   \item{net.ci}{Numeric vector; confidence intervals for net migration.}
#' }
#'
#' @details
#' Data differ slightly from the final adjusted migration estimates published by the ONS,
#' which take account of certain types of migration that the IPS does not capture, such as
#' asylum seekers, people migrating for longer or shorter than they thought they would,
#' and migration over land to and from Northern Ireland.
#'
#' @source
#' Annual statistics on flows of international migrants to and from the UK and England and Wales
#' by the Office of National Statistics. Retrieved from "1.02 IPS Margins of Error, 1975–2012" spreadsheet.
#'
#' Original spreadsheet no longer available on the ONS website, but a copy exists at
#' \url{https://github.com/guyabel/fanplot/tree/master/data-raw/}
#'
#' @examples
#' # Standard plot
#' net <- ts(ips$net, start = 1975)
#' plot(net, ylim = range(net - ips$net.ci, net + ips$net.ci))
#' lines(net + ips$net.ci, lty = 2, col = "red")
#' lines(net - ips$net.ci, lty = 2, col = "red")
#'
#' # Simulate values
#' ips.sim <- matrix(NA, nrow = 10000, ncol = length(net))
#' for (i in 1:length(net)) {
#'   ips.sim[, i] <- rnorm(10000, mean = ips$net[i], sd = ips$net.ci[i] / 1.96)
#' }
#'
#' # Spaghetti plot
#' plot(net, ylim = range(net - ips$net.ci, net + ips$net.ci), type = "n")
#' fan(ips.sim, style = "spaghetti", start = tsp(net)[1], n.spag = 50)
#'
#' # Box plot
#' plot(net, ylim = range(net - ips$net.ci, net + ips$net.ci), type = "n")
#' fan(ips.sim, style = "boxplot", start = tsp(net)[1], llab = TRUE, outline = FALSE)
#'
#' # Box fan
#' plot(net, ylim = range(net - ips$net.ci, net + ips$net.ci), type = "n")
#' fan(ips.sim, style = "boxfan", type = "interval", start = tsp(net)[1])
#'
#' @keywords datasets
"ips"