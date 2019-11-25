

library(grImport2)
library(gridSVG)
library(grid)

gridsvg("banner.svg", width=8, height=2)

gridSVG.newpage()
pushViewport(viewport(layout=grid.layout(1, 4)))

pushViewport(viewport(layout.pos.col=1))
SVGlogo <- readPicture("svg-logo-v-cairo.svg")
grid.picture(SVGlogo)
upViewport()

notrun <- function() {
    pushViewport(viewport(layout.pos.col=3))
    shape <- circleGrob(name="c", r=.4, gp=gpar(col=NA, fill=hcl(0, 60, 60)))
    maskShape <- rectGrob(x=0:2/3, width=1/3, just="left", 
                          gp=gpar(col=NA, fill=c("black", "grey", "white")))
    registerMask("vp-slice", mask(maskShape))
    grid.rect(gp=gpar(col=NA, fill=hcl(240, 60, 60)))
    grid.draw(shape)
    grid.mask("c", label="vp-slice")
    upViewport()
}

pushViewport(viewport(layout.pos.col=2))
test1 <- readPicture("test1.svg")
grid.picture(test1, ext="gridSVG")
upViewport()

pushViewport(viewport(layout.pos.col=3))
Rlogo <- readPicture("Rlogo-cairo.svg")
grid.picture(Rlogo, ext="gridSVG")
upViewport()

dev.off()



