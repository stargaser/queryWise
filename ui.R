
library(shiny)


shinyUI(pageWithSidebar(
    headerPanel("Infrared Stars and Galaxies"),
    sidebarPanel(
        numericInput("ra", label="Right Ascension (deg)", 20.0, min=0.0,
                     max=360.0),
        numericInput("dec", label="Declination (deg)", 50.0, min=-90.0,
                     max=90.0),
        sliderInput("size", label="Box size in arcminutes",
                    value = 5, min = 5, max = 30, step = 0.1),
        radioButtons("band", label="Wavelength",
                     c("3.5 microns" = 1,
                       "4.5 microns" = 2,
                       "12 microns" = 3,
                       "22 microns" = 4))
    ),
    mainPanel(
        plotOutput('skyPlot')
    )
))


