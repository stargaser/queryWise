
library(shiny)
library(markdown)


shinyUI(fluidPage(
    titlePanel("Infrared Stars and Galaxies"),
    
    sidebarLayout(
        sidebarPanel(
            numericInput("ra", label="Right Ascension (degrees)", 120.0, min=0.0,
                         max=360.0, step=5),
            numericInput("dec", label="Declination (degrees)", 50.0, min=-90.0,
                         max=90.0, step=5),
            sliderInput("size", label="Box size (arcminutes)",
                        value = 5, min = 5, max = 15, step = 0.25),
            radioButtons("band", label="Wavelength",
                         c("3.5 microns" = 1,
                           "4.5 microns" = 2,
                           "12 microns" = 3,
                           "22 microns" = 4))
        ),
        mainPanel(
            plotOutput('skyPlot'),
            includeMarkdown("include.md")
        )
    )
))


