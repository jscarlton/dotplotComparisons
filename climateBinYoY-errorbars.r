# Set up data. Severity will provide the labels, pre is the pre-drought mean (i.e., effect size estimate), post is the post-drought mean. lowerCIpre and upperCIpre are the lower and upper bounds of the 95% confidence intervals for the pre-drought data, lowerCIpost and upperCIpost are the same for the post-drought data. If I were fancier, I could calculate those and store them as variables rather than manually input them from prior analysis. But I'm not that fancy.
severity = c("Overall average","Lowest quartile","Second quartile","Third quartile","Highest quartile")
pre = c(72.8,73.2,74.2,73.8,70.5)
post = c(73.6,81.5,73.0,74.4,67.1)
lowerCIpre = c(69.5,66.5,67.7,67.0,64.3)
upperCIpre = c(76.1,79.9,80.6,80.5,76.8)
lowerCIpost = c(70.4,75.7,66.5,67.7,60.7)
upperCIpost = c(76.9,87.4,79.6,81.1,73.6)


# Generate numbers for the y-axis.
y.axis <- length(severity):1

# Generate an adjustment value to move the dots up or down so you can see the intervals
adjustment <- 0.15

png("climateBinYoY-errorbars.png", height = 6, width = 8.5, units = "in",res=600)


par(mar=c(4.5,7.5,.5,1), lheight = .3)

plot(pre, y.axis + adjustment, type = "p", axes=F, xlab = "% Believing in climate change", ylab = "", cex = 1.4, xlim = c(0,100), ylim = c(min(y.axis - adjustment), max(y.axis + adjustment)), main = "")

abline(h = y.axis, lty = 2, lwd = 1, col = "light grey")

points(post, y.axis - adjustment, pch = 21, cex = 1.4, bg = "gray" )

# CI Bars using the arrows command. lwd adjusts line width
arrows(lowerCIpre, y.axis + adjustment, upperCIpre, y.axis + adjustment, code = 3, length = 0.05, angle = 90)

arrows(lowerCIpost, y.axis - adjustment, upperCIpost, y.axis - adjustment, code = 3, length = 0.05, angle = 90)

# re-draw the dots to make them appear over the CI lines
points(pre, y.axis + adjustment, pch = 21, cex = 1.4, bg = "white" )
points(post, y.axis - adjustment, pch = 21, cex = 1.4, bg = "gray" )


axis(1,at = seq(0,100, by = 20), label = seq(0,100, by = 20), mgp = c(.5,.6,.50), cex.axis = 1)

axis(2, at = y.axis, label = severity, las = 1, tick = T, cex.axis =1.0)



text(15,4.5, "Pre-drought", adj=0, cex = .8) # key labels
text(15,4.35, "Post-drought", adj=0, cex = .8)
points(13,4.51, cex = 1.4)
points(13,4.36,pch = 21, bg = "gray", cex = 1.4)

dev.off()


# Another way of displaying the error bars is as plain old lines, not arrows. This requires a few hacks (using segments and arrows, for example) and reducing the outline of the points (using lwd) for aesthetic purposes. I think the aesthetics of this could be improved, but this will do for now.

png("climateBinYoY-errorlines.png", height = 6, width = 8.5, units = "in",res=600)


par(mar=c(4.5,7.5,.5,1), lheight = .3)

plot(pre, y.axis + adjustment, type = "p", axes=F, xlab = "% Believing in climate change", ylab = "", cex = 1.4, xlim = c(0,100), ylim = c(min(y.axis - adjustment), max(y.axis + adjustment)), main = "", lwd = 0.5)

abline(h = y.axis, lty = 2, lwd = 1, col = "light grey")

points(post, y.axis - adjustment, pch = 21, cex = 1.4, bg = "gray", lwd = 0.5 )

# Use a combination of the arrows and segments command to create the error bars. The segments makes the lines and the arrows makes the end of the lines.

arrows(lowerCIpre, y.axis + adjustment, upperCIpre, y.axis + adjustment, code = 3, length = 0.05, angle = 90, col = "gray70", lwd = 2.5)
segments(lowerCIpre, y.axis + adjustment, upperCIpre, y.axis + adjustment, col = "gray70", lwd = 5, lend = 1)

arrows(lowerCIpost, y.axis - adjustment, upperCIpost, y.axis - adjustment, code = 3, length = 0.05, angle = 90, col = "gray70", lwd = 2.5)
segments(lowerCIpost, y.axis - adjustment, upperCIpost, y.axis - adjustment, col = "gray70", lwd = 5, lend = 1)

# re-draw the dots to make them appear over the CI lines
points(pre, y.axis + adjustment, pch = 21, cex = 1.4, bg = "white", lwd = 0.5 )
points(post, y.axis - adjustment, pch = 21, cex = 1.4, bg = "gray", lwd = 0.5 )


axis(1,at = seq(0,100, by = 20), label = seq(0,100, by = 20), mgp = c(.5,.6,.50), cex.axis = 1)

axis(2, at = y.axis, label = severity, las = 1, tick = T, cex.axis =1.0)



text(15,4.5, "Pre-drought", adj=0, cex = .8) # key labels
text(15,4.35, "Post-drought", adj=0, cex = .8)
points(13,4.51, cex = 1.4, lwd = 0.5)
points(13,4.36,pch = 21, bg = "gray", cex = 1.4, lwd = 0.5)

dev.off()