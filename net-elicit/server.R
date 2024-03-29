library(shiny)
library(fanplot)
library(RColorBrewer)
library(colorspace)

net<-ts(ips$net, start=1975)
n<-length(net)
y0<-time(net)[n]+1

d0<-data.frame(year=y0:2030, mode=net[n], sd=100, skew=0)

shinyServer(function(input, output) {
  output$year1 <- renderUI({
    if(input$cp>=1)
      sliderInput("year1", h5("Change Point 1:"),
                  min = y0, max = 2030, value = y0+1, step= 1, sep="")
  })
  output$mode1 <- renderUI({
    if(input$cp>=1)
      sliderInput("mode1", paste0(input$year1,": Central Prediction"), 
                  min = -1000, max = 1000, value = net[n], step= 1)
  })
  output$sd1 <- renderUI({
    if(input$cp>=1)
      sliderInput("sd1", paste0(input$year1,": Uncertinty "), 
                  min = 0.001, max = 1000, value = 100,  step= 1)
  })
  output$skew1 <- renderUI({
    if(input$cp>=1)
      sliderInput("skew1", paste0(input$year1,": Skewness "), 
                  min = -0.99, max = 0.99, value = 0, step= 0.01)
  })
  output$year2 <- renderUI({
    if(input$cp>=2)
      sliderInput("year2", h5("Change Point 2:"),
                  min = input$year1+1, max = 2030, value = input$year1+1, step= 1, sep="")
  })
  output$mode2 <- renderUI({
    if(input$cp>=2)
      sliderInput("mode2", paste0(input$year2,": Central Prediction"),
                  min = -1000, max = 1000, value = net[n], step= 1)
  })
  output$sd2 <- renderUI({
    if(input$cp>=2)
      sliderInput("sd2", paste0(input$year2,": Uncertinty "),
                  min = 0.001, max = 1000, value = 100,  step= 1)
  })
  output$skew2 <- renderUI({
    if(input$cp>=2)
      sliderInput("skew2", paste0(input$year2,": Skewness "),
                  min = -0.99, max = 0.99, value = 0, step= 0.01)
  })
  
  output$year3 <- renderUI({
    if(input$cp>=3)
      sliderInput("year3", h5("Change Point 3:"),
                  min = input$year2+1, max = 2030, value = input$year2+1, step= 1, sep="")
  })
  output$mode3 <- renderUI({
    if(input$cp>=3)
      sliderInput("mode3", paste0(input$year3,": Central Prediction"),
                  min = -1000, max = 1000, value = net[n], step= 1)
  })
  output$sd3 <- renderUI({
    if(input$cp>=3)
      sliderInput("sd3", paste0(input$year3,": Uncertinty "),
                  min = 0.001, max = 1000, value = 100,  step= 1)
  })
  output$skew3 <- renderUI({
    if(input$cp>=3)
      sliderInput("skew3",  paste0(input$year3,": Skewness "),
                  min = -0.99, max = 0.99, value = 0, step= 0.01)
  })
  # input <- NULL
  # input$mode0 <- 100
  get_d<- reactive({
    d <- rbind(data.frame(year=y0-1, mode=net[n], sd=1, skew=0), d0)
    #if(!is.null(input$cp)){
    if(input$cp==0){
      d$mode<-approx(x = c(y0-1,        2030),
                       y = c(d$mode[1], input$mode0),
                       n = nrow(d))$y
      d$sd <- approx(x = c(y0-1,      2030),
                       y = c(d$sd[1], input$sd0),
                       n = nrow(d))$y
      d$skew<-approx(x = c(y0-1,        2030),
                       y = c(d$skew[1], input$skew0),
                       n = nrow(d))$y
    }
    if(input$cp==1 & !is.null(input$year1)  & !is.null(input$mode1)  & !is.null(input$sd1)  & !is.null(input$skew1)){
      d$mode<-approx(x = c(y0-1,        input$year1, 2030),
                       y = c(d$mode[1], input$mode1, input$mode0),
                       n = nrow(d))$y
      d$sd <- approx(x = c(y0-1,      input$year1, 2030),
                       y = c(d$sd[1], input$sd1,   input$sd0),
                       n = nrow(d))$y
      d$skew<-approx(x = c(y0-1,        input$year1,  2030),
                       y = c(d$skew[1], input$skew1, input$skew0),
                       n = nrow(d))$y
    }
    if(input$cp==2 & !is.null(input$year2)  & !is.null(input$mode2)  & !is.null(input$sd2)  & !is.null(input$skew2)){
      d$mode<-approx(x = c(y0-1,        input$year1, input$year2, 2030),
                       y = c(d$mode[1], input$mode1, input$mode2, input$mode0),
                       n = nrow(d))$y
      d$sd <- approx(x = c(y0-1,      input$year1, input$year2, 2030),
                       y = c(d$sd[1], input$sd1,   input$sd2,   input$sd0),
                       n = nrow(d))$y
      d$skew<-approx(x = c(y0-1,        input$year1, input$year2, 2030),
                       y = c(d$skew[1], input$skew1, input$skew2, input$skew0),
                       n = nrow(d))$y
    }
    if(input$cp==3 & !is.null(input$year3)  & !is.null(input$mode3)  & !is.null(input$sd3)  & !is.null(input$skew3)){
      d$mode<-approx(x = c(y0-1,        input$year1, input$year2, input$year3, 2030),
                       y = c(d$mode[1], input$mode1, input$mode2, input$mode3, input$mode0),
                       n = nrow(d))$y
      d$sd <- approx(x = c(y0-1,      input$year1, input$year2, input$year3, 2030),
                       y = c(d$sd[1], input$sd1,   input$sd2,   input$sd3,   input$sd0),
                       n = nrow(d))$y
      d$skew<-approx(x = c(y0-1,        input$year1, input$year2, input$year3, 2030),
                       y = c(d$skew[1], input$skew1, input$skew2, input$skew3, input$skew0),
                       n = nrow(d))$y
    }
    
#     d<-d
    return(d)
  })
  netstats <- reactive({
    d<-get_d()
    k<-nrow(d)-1
    # val <- matrix(NA, nrow = 6, ncol = k)
    val <- matrix(NA, nrow = 99, ncol = k)
    med <- rep(NA, k)
    for (i in 1:k){
      val[, i] <- qsplitnorm(
        p= seq(0.01, 0.99, 0.01), 
        # p=c(0.025, 0.1, 0.25, 0.75, 0.9, 0.975), 
                             mode = d$mode[i+1],
                             sd = d$sd[i+1],
                             skew = d$skew[i+1])
      med[i] <- qsplitnorm(p=0.5, 
                        mode = d$mode[i+1],
                        sd = d$sd[i+1],
                        skew = d$skew[i+1])
    }
    return(list(val=val,med=med))
    
  })
  output$plot <- renderPlot({
    netstats<-netstats()
    val<-netstats$val
    med<-netstats$med
    par(mar=c(2,4,2,2))
    plot(y0-1, net[n], las=1, ylab="", ylim=range(c(net-ips$net.ci, net+ips$net.ci,val)), xlim=range(c(time(net),2035)))
    if(input$past)
      lines(net, lwd=2)
    if(input$ipsci){
      lines(net+ips$net.ci, lty=2, col="red")
      lines(net-ips$net.ci, lty=2, col="red")
    }
    grid()
    lcol <- adjust_transparency(col = "red", alpha = 0.25)
    fan(val, data.type="values", start=y0, ln = c(10, 25, 75, 90), 
        fan.col = colorRampPalette(colors = rev(brewer.pal(9,"Reds"))), 
        ln.col = lcol)
    lines(ts(med, start=y0), col=lcol)
    text(2030, med[length(med)], "Med", pos=4, offset=0.1, cex=0.8)
  })
  output$df <- renderDataTable({
    d<-get_d()
    d[-1,]
    d<-round(d,2)
  }, options = list(filter = FALSE, searching=FALSE, paging=FALSE, info=FALSE, ordering=FALSE))

  output$downloadData <- downloadHandler(
    filename = function() {
      paste('data-', Sys.Date(), '.csv', sep='')
    },
    content = function(filename) {
      write.csv(get_d(), row.names = FALSE)
    }
  )
})