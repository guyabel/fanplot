#' Fan Plot of Distribution Percentiles Over Time
#'
#' Visualise sequential distributions using a range of plotting styles.
#'
#' @param data Set of sequential simulation data, where rows represent simulation number
#'   and columns represent some form of time index. If \code{data.type = "values"},
#'   data must instead be a set of quantile values by rows for a set of probabilities
#'   (which need to be provided in \code{probs}) and by column for some form of time index.
#'   Data can take multiple classes, where the contents are converted to a \code{matrix}.
#'   If the input is a \code{mts} or \code{zoo}, the time series properties will be inherited
#'   (and \code{start} and \code{frequency} arguments will be ignored).
#' @param data.type Indicates if \code{data} are sets of pre-calculated values for defined
#'   probabilities (\code{"values"}) or simulated data (\code{"simulations"}). Default is \code{"simulations"}.
#' @param style Plot style, choose from \code{"fan"} (default), \code{"spaghetti"}, \code{"boxplot"} or \code{"boxfan"}.
#' @param type Type of percentiles to plot in \code{fan} or \code{boxfan}. Choose from \code{"percentile"} (default) or \code{"interval"}.
#' @param probs Probabilities related to percentiles or prediction intervals to be plotted
#'   (dependent on the \code{type} argument). Must be between 0 and 100 (inclusive) or 0 and 1.
#'   Percentiles greater than 50 (or 0.5), if not given, are automatically calculated as 100 - \code{p},
#'   to ensure symmetric fan. Defaults to single percentile values when \code{type = "percentile"}
#'   and the 50th, 80th and 95th prediction interval when \code{type = "interval"}.
#' @param start The time of the first distribution in \code{sims}. Similar to use in \code{\link{ts}}.
#' @param frequency The number of distributions in \code{sims} per unit of time. Similar to use in \code{\link{ts}}.
#' @param anchor Optional data value to anchor a forecast fan on. Typically the last observation of the observed series.
#' @param anchor.time Optional time value for the anchor. Useful for irregular time series.
#' @param fan.col Palette of colours used in the \code{fan} or \code{boxfan}.
#' @param n.fan Number of colours to use in the fan.
#' @param alpha Factor modifying the opacity alpha; typically in [0,1].
#' @param ln Vector of numbers to plot contour lines on top of \code{fan} or \code{boxfan}.
#'   Must correspond to calculated percentiles in \code{probs}.
#' @param med.ln Logical; add a median line to fan. Useful if \code{type = "interval"}.
#' @param ln.col Line colour imposed on top of the fan. Defaults to darkest colour from \code{fan.col},
#'   unless \code{style = "spaghetti"}.
#' @param med.col Median line colour. Defaults to first colour in \code{fan.col}.
#' @param rlab Vector of labels at the end (right) of corresponding percentiles or prediction intervals.
#' @param rpos Position of right labels. See \code{\link{text}}.
#' @param roffset Offset of right labels. See \code{\link{text}}.
#' @param rcex Text size of right labels. See \code{\link{text}}.
#' @param rcol Colour of text for right labels. See \code{\link{text}}.
#' @param llab Either logical (TRUE/FALSE) to plot labels at the start (left) of percentiles,
#'   or a vector of percentiles. Only works for \code{fan} or \code{boxfan}.
#' @param lpos Position of left labels. See \code{\link{text}}.
#' @param loffset Offset of left labels. Defaults to \code{roffset}.
#' @param lcex Text size of left labels. Defaults to \code{rcex}.
#' @param lcol Colour of text for left labels. Defaults to \code{rcol}.
#' @param upplab Prefix string for upper labels when \code{type = "interval"}.
#' @param lowlab Prefix string for lower labels when \code{type = "interval"}.
#' @param medlab Character string for median label.
#' @param n.spag Number of simulations to plot in the \code{spaghetti} style.
#' @param space Space between boxes in the \code{boxfan} plot.
#' @param add Logical; add to active plot. Defaults to \code{FALSE} for \code{fan}, \code{TRUE} for \code{fan0}.
#' @param ylim Passed to \code{plot} when \code{add = TRUE}.
#' @param ... Additional arguments passed to \code{\link{boxplot}} for \code{fan} and to \code{\link{plot}} for \code{fan0}.
#'
#' @details
#' Sequential distribution data can be input as either simulations or pre-computed values over time (columns).
#' For the latter, declare input data as percentiles by setting \code{data.type = "values"}.
#' Users can choose from four styles:
#' \itemize{
#'   \item \code{fan}, \code{boxfan}: shaded distributions with optional contour lines and labels.
#'   \item \code{spaghetti}: random draws plotted along the sequence of distributions.
#'   \item \code{boxplot}: box plots for simulated data at appropriate locations.
#' }
#'
#' @return See details.
#'
#' @references
#' Abel, G. J. (2015). fanplot: An R Package for visualising sequential distributions.
#' \emph{The R Journal}, 7(2), 15--23.
#'
#' @author Guy J. Abel
#'
#' @examples
#' ## Basic Fan: fan0()
# fan0(th.mcmc)
# 
# ##
# ## Basic Fan: fan()
# ##
# ### empty plot
# plot(NULL, xlim = c(1, 945), ylim = range(th.mcmc)*0.85)
# 
# # add fan
# fan(th.mcmc)
#' 
#' ##
#' ## 20 or so examples of fan charts and
#' ## spaghetti plots based on the th.mcmc object
#' ##
#' ## Make sure you have zoo, tsbugs, RColorBrewer and 
#' ## colorspace packages installed
#' ##
#' \dontrun{
#' demo("sv_fan", "fanplot")
#' }
#' 
#' ##
#' ## Fans for forecasted values
#' ##
#' \dontrun{
#' #create time series
#' net <- ts(ips$net, start=1975)
#'   
#' # fit model
#' library("forecast")
#'   m <- auto.arima(net)
#'   
#' # plot in forecast package (limited customisation possible)
#' plot(forecast(m, h=5))
#'   
#' # another plot in forecast (with some customisation, no
#' # labels or anchoring possible at the moment)
#' plot(forecast(m, h=5, level=c(50,80,95)), 
#'        shadecols=rev(heat.colors(3)))
#'   
#' # simulate future values
#'   mm <- matrix(NA, nrow=1000, ncol=5)
#'   for(i in 1:1000)
#'     mm[i,] <- simulate(m, nsim=5)
#'   
#'   # interval fan chart
#'   plot(net, xlim=c(1975,2020), ylim=c(-100,300))
#'   fan(mm, type="interval", start=2013)
#' 
#'   # anchor fan chart
#'   plot(net, xlim=c(1975,2020), ylim=c(-100,300))
#'   fan(mm, type="interval", start=2013, 
#'       anchor=net[time(net)==2012])
#' 
#'   # anchor spaghetti plot with underlying fan chart
#'   plot(net, xlim=c(1975,2020), ylim=c(-100,300))
#'   fan(mm, type="interval", start=2013, 
#'       anchor=net[time(net)==2012], alpha=0, ln.col="orange")
#'   fan(mm, type="interval", start=2013, 
#'       anchor=net[time(net)==2012], alpha=0.5, style="spaghetti")
#' }
#' 
#' ##
#' ## Box Plots
#' ##
#' # sample every 21st day of theta_t
#' th.mcmc21 <- th.mcmc[, seq(1, 945, 21)]
#' plot(NULL, xlim = c(1, 945), ylim = range(th.mcmc21))
#' fan(th.mcmc21, style = "boxplot", frequency = 1/21)
#' 
#' # additional arguments for boxplot
#' plot(NULL, xlim = c(1, 945), ylim = range(th.mcmc21))
#' fan(th.mcmc21, style = "boxplot", frequency = 1/21, 
#'     outline = FALSE, col = "red", notch = TRUE)
#' 
#' ##
#' ## Fan Boxes
#' ##
#' plot(NULL, xlim = c(1, 945), ylim = range(th.mcmc21))
#' fan(th.mcmc21, style = "boxfan", type = "interval", frequency = 1/21)
#' 
#' # more space between boxes
#' plot(NULL, xlim = c(1, 945), ylim = range(th.mcmc21))
#' fan(th.mcmc21, style = "boxfan", type = "interval", 
#'     frequency = 1/21, space = 10)
#' 
#' # overlay spaghetti
#' fan(th.mcmc21, style = "spaghetti", 
#'     frequency = 1/21, n.spag = 50, ln.col = "red", alpha=0.2) 
#' 
#'
#' @aliases fan fan0
#' @export

fan <-
  function(data = NULL, data.type="simulations", style = "fan", type = "percentile",
           probs = if(type=="percentile") seq(0.01, 0.99, 0.01) else c(0.5, 0.8, 0.95), 
           start = 1, frequency = 1, anchor = NULL, anchor.time=NULL,
           fan.col = grDevices::heat.colors, alpha = if (style == "spaghetti") 0.5 else 1, 
           n.fan = NULL,
           ln = if(length(probs)<10) probs else 
             probs[round(probs,2) %in% round(seq(0.1, 0.9, 0.1),2)],
           ln.col = if(style=="spaghetti") "gray" else NULL, 
           med.ln = if(type=="interval") TRUE else FALSE, 
           med.col= "orange",
           rlab = ln, rpos = 4, roffset = 0.1, rcex = 0.8, rcol = NULL, 
           llab = FALSE, lpos = 2, loffset = roffset, lcex = rcex, lcol = rcol, 
           upplab = "U", lowlab = "L", medlab=if(type == "interval") "M" else NULL,
           n.spag = 30, 
           space = if(style=="boxplot") 1/frequency else 0.9/frequency, 
           add = FALSE, ylim = range(data)*0.8,...){
      
    #probs[round(probs,2) %in% c(0.05,0.10,0.20,0.50,0.80,0.90,0.95)]
    if(add==TRUE)
      plot(data[,1], type="n", ylim=ylim, ...)
    
    ##
    ##check inputs
    ##
    if(!(data.type %in% c("values","simulations")))
      stop("data.type must be set to one of: values, simulations")
    if(!(style %in% c("fan","boxfan","spaghetti","boxplot")))
      stop("style must be set to one of: fan, boxfan, spaghetti or boxplot")
    
    ##
    ##data classes
    ##
    if(methods::is(data, "mts")[1]){
      start<-start(data)[1]
      frequency<-frequency(data)
    }
    
    ##
    ##create pp and tt
    ##
    if(style=="fan" | style=="boxfan" | style=="spaghetti"){
      if(!(type %in% c("percentile","interval")))
        stop("type must be set to one of: percentile or interval")
      #ensure p is okay
      p<-probs
      if(min(p)<0 | max(p)>100)
        stop("all probs must be between 0 and 1 (or 0 and 100)")
      if(max(p)>1)
        p<-p/100
      #make p symetrical
      if(type=="percentile")
        p<-c(p,1-p)
      if(type=="interval" & data.type=="simulations")
        p <- c(p + (1-p)/2, 1 - p - (1-p)/2)
      p<-round(p,5) #i dont know why, but you need this otherwise not unique
      p<-sort(unique(p))
      
      #work out quantiles
      if(data.type=="simulations"){
        pp<-as.matrix(data)
        pp<-apply(pp,2,stats::quantile,probs=p)
      }
      if(data.type=="values"){
        pp<-as.matrix(data)
        if(type=="percentile" & length(p)!=nrow(pp))
          stop("probs must correspond to the nrows of data if data.type==values and type is percentile")
        if(type=="interval" & length(probs)!=2*nrow(pp)){
          p<-probs
          p<-c(p + (1-p)/2, 1 - p - (1-p)/2)
          p<-sort(p)
          p <- round(p,5)
        }
      }
      n<-nrow(pp)
      if(type=="interval"){
        rownames(pp)<-paste0(rep(c(lowlab,upplab),each=n/2), 200*abs(0.5-p)  ,"%")
      }
      
      #add ancohor
      if(!is.null(anchor)){
        pp<-cbind(rep(anchor,n),pp)
      }
      #transform pp
      pp<-t(pp)
      
      
      #ts info
      if(!methods::is(data, "zoo")[1]){
        ppts <- stats::ts(pp, start = start, frequency = frequency)
        tt<-stats::time(ppts)
        tt<-as.numeric(tt)
        if(!is.null(anchor)){
          ppts <- stats::ts(pp, start = stats::time(stats::lag(ppts))[1], frequency = frequency)
          tt <- stats::time(ppts)
          tt<-as.numeric(tt)
        }
      }
      if(methods::is(data, "zoo")[1]){
        tt<-stats::time(data)
        if(!is.null(anchor))
          tt<-c(anchor.time,tt)
      }
    }
    
    ##
    ##fan colours
    ##
    if(style=="fan" | style=="boxfan"){
      #plot polygons
      if(is.null(n.fan))
        fan.col<-fan.col(floor(n/2))
      if(!is.null(n.fan))
        fan.col<-fan.col(n.fan)
      fan.col <- grDevices::adjustcolor(fan.col,alpha.f=alpha)
      if(is.null(ln.col))
        ln.col<-fan.col[1]
    }
    
    ##
    ##fan plot
    ##
    if(style=="fan"){
      fan.fill<-function(ts1, ts2, tt, fan.col="grey"){
        xx <- cbind(tt,rev(tt)) 
        yy <- cbind(as.vector(ts1),rev(as.vector(ts2)))
        graphics::polygon(x = xx, y = yy, col = fan.col, border = fan.col)
      }
      #plot(cpi, type = "l", xlim = c(y0-5, y0+3), ylim = c(-2, 7))
      #plot(NULL, type = "n", xlim = c(1, 945),  ylim = range(th.mcmc), ylab = "Theta")
      #plot(net, ylim=range(net-ips$net.ci, net+ips$net.ci), type = "n")
      for(i in 1:floor(n/2)){
        fan.fill(ts1=pp[,i],ts2=pp[,n-i+1],tt=tt, fan.col=fan.col[floor(n/2)+1-i])
      }
    }   
    
    ##
    ##plot box fans
    ##
    if(style=="boxfan"){
      #single time series to use for at=time 
      x<-pp[,1]
      for(i in 1:nrow(pp)){
        for(j in 1:floor(n/2)){
          graphics::rect(xleft=tt[i]-0.5*space, ybottom=pp[i,j], xright=tt[i]+0.5*space, ytop=pp[i,n-j+1], col=fan.col[floor(n/2)+1-j], border=fan.col[floor(n/2)+1-j])
        }
      }
    }
    
    ##
    ##contour lines
    ##
    if(style=="fan" | style=="boxfan"){
      #ln=seq(5,95,15); llab=seq(5,95,15); rlab=c(80,50,20); 
      #ensure rlab will evaluate to original ln rather than altered
      ln0<-ln
      #ensure ln is okay
      if(!is.null(ln0)){
        if(min(ln0)<0 | max(ln0)>100)
          stop("all ln must be between 0 and 1 (or 0 and 100)")
        if(max(ln0)>1)
          ln0<-ln0/100
        #default lines on available pi
        if(type=="interval"){
          ln0 <- c(ln0 + (1-ln0)/2, 1 - ln0 - (1-ln0)/2)
          ln0 <-sort(ln0)
        }
        ln0<-round(ln0,5)
        #plot lines
        if(style=="fan"){
          for(i in match(ln0, p))
            graphics::lines(x=tt, y=pp[,i], col=ln.col)
        }
        if(style=="boxfan"){
          for(i in 1:nrow(pp)){
            for(j in match(ln0, p)){
              graphics::lines(x=tt[i]+c(-0.5,0.5)*space, y=rep(pp[i,j],2), col=ln.col)
            }
          }
        }
        if(is.na(sum(match(ln0,p))))
          print("some lines not plotted as conflict with precentiles given in probs")
      }
    }
    
    ##
    ##labels
    ##
    if(style=="fan" | style=="boxfan"){
      #names will be plotted in text
      if(data.type=="values" & type=="percentile")
        colnames(pp)<-paste0(p*100, "%")
      #default right text on available deciles
      if(!is.null(rlab)){
        if(min(rlab)<0 | max(rlab)>100)
          stop("all rlab must be between 0 and 1 (or 0 and 100)")
        if(max(rlab)>1)
          rlab<-rlab/100
        if(type=="interval")
          rlab<-c(rlab + (1-rlab)/2, 1 - rlab - (1-rlab)/2)
        rlab<-sort(rlab)
        rlab<-round(rlab, 5)
        for(i in match(rlab, p)){
          if(style=="fan")
            graphics::text(tt[length(tt)], pp[nrow(pp),i], colnames(pp)[i], pos=rpos, offset=roffset, cex=rcex, col=rcol)
          if(style=="boxfan")
            graphics::text(tt[length(tt)]+0.5*space, pp[nrow(pp),i], colnames(pp)[i], pos=rpos, offset=roffset, cex=rcex, col=rcol)
        }
        if(is.na(sum(match(rlab,p))))
          print("some right labels not plotted as conflict with precentiles given in probs")
      }
      if(is.numeric(llab[1]) | llab[1]==TRUE){
        if(is.numeric(llab[1])){
          if(min(llab)<0 | max(llab)>100)
            stop("all llab must be between 0 and 1 (or 0 and 100)")
          if(max(llab)>1)
            llab<-llab/100
          if(type=="interval")
            llab <- c(llab + (1-llab)/2, 1 - llab - (1-llab)/2)
          llab<-sort(llab)
          llab<-round(llab, 5)
        }
        if(llab[1]==TRUE)
          llab<-rlab
        for(i in match(llab, p)){
          if(style=="fan")
            graphics::text(tt[1], pp[1,i],  colnames(pp)[i], pos=lpos, offset=loffset, cex=lcex, col=lcol)
          if(style=="boxfan")
            graphics::text(tt[1]-0.5*space, pp[1,i], colnames(pp)[i], pos=lpos, offset=loffset, cex=lcex, col=lcol)
        }
        if(is.na(sum(match(llab,p))))
          print("some left labels not plotted as conflict with precentiles given in probs")
      }
    }
    
    #add median line and labels
    if(style=="fan" | style=="boxfan"){
      if(med.ln==TRUE & data.type=="simulations"){
        pp<-data
        pm<-apply(pp,2,stats::median)
        if(!is.null(anchor))
          pm<-c(anchor,pm)
        if(is.null(med.col))
          med.col<-ln.col
        if(style=="fan"){
          graphics::lines(x=tt, y=pm, col=med.col)
        }
        if(style=="boxfan"){
          for(i in 1:nrow(pp)){
            #lines(x=(i-1)/frequency+c(-0.5,0.5)*space, y=rep(pm[i],2), col=med.col)
            graphics::lines(x=tt[i]+c(-0.5,0.5)*space, y=rep(pm[i],2), col=med.col)
          }
        }
        if(!is.null(rlab) & style %in% c("fan","spaghetti"))
          graphics::text(tt[length(tt)], pm[length(pm)], medlab, pos=rpos, offset=roffset, cex=rcex, col=rcol)
        if(!is.null(rlab) & style=="boxfan")
          graphics::text(tt[length(tt)]+0.5*space, pm[length(pm)], medlab, pos=rpos, offset=roffset, cex=rcex, col=rcol)
        if(any(llab==TRUE,is.numeric(llab)) & style %in% c("fan","spaghetti"))
          graphics::text(tt[1], pm[1], medlab, pos=lpos, offset=loffset, cex=lcex, col=lcol)
        if(any(llab==TRUE,is.numeric(llab)) & style=="boxfan")
          graphics::text(tt[1]-0.5*space, pm[1], medlab, pos=lpos, offset=loffset, cex=lcex, col=lcol)
      }
    }
    
    ##
    ##plot spaghetti
    ##
    if(style=="spaghetti"){
      ps<-as.matrix(data)
      n<-nrow(ps)
      ps<-ps[sample(1:n,n.spag),]
      #add ancohor
      if(!is.null(anchor))
        ps<-cbind(rep(anchor,nrow(ps)),ps)
      spag.col <- grDevices::adjustcolor(ln.col,alpha.f=alpha)
      for(i in 1:nrow(ps))
        graphics::lines(x=tt, y=ps[i,], col=spag.col)
    }
    
    ##
    ##box plots
    ##
    if(style=="boxplot"){
      if(data.type=="values")
        stop(print("data must be simulations"))
      pp<-data
      n<-ncol(pp)
      if(!is.null(anchor))
        print("anchor ignored for boxplots plots")
      #single time series to use for at=time 
      p<-stats::ts(pp[1,], start=start, frequency=frequency)
      #plot(NULL, type = "n", xlim = c(1, 10),  ylim = range(pp), ylab = "Theta")
      for(i in 1:n)
        graphics::boxplot(pp[,i], add=TRUE, at=stats::time(p)[i], boxwex=space, xaxt = "n", yaxt = "n",...)
    }
    graphics::box()
  }

fan0 <-
  function(data = NULL, data.type = "simulations", style = "fan", type = "percentile",
           probs = if(type=="percentile") seq(0.01, 0.99, 0.01) else c(0.5, 0.8, 0.95), 
           start = 1, frequency = 1, anchor = NULL, anchor.time=NULL,
           fan.col = grDevices::heat.colors, alpha = if (style == "spaghetti") 0.5 else 1, 
           n.fan = NULL,
           ln = NULL, ln.col = if(style=="spaghetti") "gray" else NULL, 
           med.ln = if(type=="interval") TRUE else FALSE, med.col= "orange",
           rlab = ln, rpos = 4, roffset = 0.1, rcex = 0.8, rcol = NULL, 
           llab = FALSE, lpos = 2, loffset = roffset, lcex = rcex, lcol = rcol, 
           upplab = "U", lowlab = "L", medlab=if(type == "interval") "M" else NULL,
           n.spag = 30, 
           space = if(style=="boxplot") 1/frequency else 0.9/frequency, 
           add = TRUE, ylim = range(data)*0.8,...){
    if(add==TRUE)
      plot(data[,1], type="n", ylim=ylim, ...)
    fan(data = data, data.type=data.type, style = style, type = type,
        probs = probs, 
        start = start, frequency = frequency, anchor = anchor, anchor.time=anchor.time,
        fan.col = fan.col, alpha = alpha, 
        n.fan = n.fan,
        ln = ln, ln.col = ln.col, 
        med.ln = med.ln, med.col= med.col,
        rlab = rlab, rpos = rpos, roffset = roffset, rcex = rcex, rcol = rcol, 
        llab = llab, lpos = lpos, loffset = loffset, lcex = lcex, lcol = lcol, 
        upplab = upplab, lowlab = lowlab, medlab=medlab,
        n.spag = n.spag, 
        space = space, 
        add = FALSE)
  }
