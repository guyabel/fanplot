##
##Compress
##
tools::checkRdaFiles("./data")
tools::resaveRdaFiles("./data")


##
##demos
##
demo(net_elicit, package = "fanplot", ask = FALSE)

par(mfrow = c(10,2))
demo(sv_fan, package = "fanplot", ask = FALSE)