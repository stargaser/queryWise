library(ggplot2)
library(mapproj)
library(shiny)

shinyServer(
    function(input, output) {
        output$skyPlot <- renderPlot({
            myra <- input$ra
            mydec <- input$dec
            mysize <- input$size*60
            myband <- input$band
            gatorUrl <- paste0("http://irsa.ipac.caltech.edu/cgi-bin/Gator/nph-query?",
                               "catalog=wise_allwise_p3as_psd&spatial=box&radius=",
                               sprintf("%d",mysize),
                               "&radunits=arcsec&objstr=",sprintf("%fd",myra),
                               sprintf("+%+fd",mydec), "&size=",sprintf("%d",mysize),
                               "&outfmt=1&selcols=ra,dec,w1mpro,w2mpro,w3mpro,w4mpro")
            irsa_result <- readLines(gatorUrl)
            # Pull out the appropriate line
            data_lines <- irsa_result[grep("^ ", irsa_result)]
            df <- read.table(text=data_lines, col.names=c('ra','dec','clon','clat',
                                                          'mag3.5','mag4.5','mag12','mag22'))
            if (myband ==4) {
                mymag <- df$mag22
                myname <- "22 microns"
            } else if (myband == 2) {
                mymag <- df$mag4.5
                myname <- "4.5 microns"
            } else if (myband == 3) {
                mymag <- df$mag12
                myname <- "12 microns"
            } else
                mymag <- df$mag3.5
                myname <- "3.5 microns"
        
            skyplot2 <- ggplot(data = df, aes(x = ra, dec)) +
                labs(x="Right Ascension(deg)", y="Declination (deg)",
                     title=paste("WISE Stars and Galaxies at ",myname))
            skyplot2 + coord_map(projection="gnomonic",
                                 orientation=c(mydec,myra,0)) + 
                geom_point(aes(color = mymag, size=14-mymag)) +
                scale_color_continuous(name="Magnitude") +
                scale_size_continuous(name="Magnitude", limits = c(-2, 8), 
                                      breaks=c(-2,0,2,4,6), 
                                      labels=c("16","14","12","10","8"))
            
       
        })
    }
)
