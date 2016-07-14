shinyUI(
    navbarPage("Economic Dispatch",id="nav",
        tabPanel("Power Plants",tags$head(includeCSS("styles.css")),
                tabsetPanel(type="tabs",
                    tabPanel("Power Generation Data",
                        fluidRow(
                            column(4,
                                wellPanel(
                                    h4("Expected Electric Load"),
                                    helpText("Choose a number MW with the slider."),
                                    numericInput("pt","Power Load in MW",min=350,max=1420,value=885),
                                    hr(),
                                    wellPanel(
                                        HTML('<small><p align="justify"',
                                             markdownToHTML(fragment.only=TRUE, text=c("`Dispatch Table:` Shows the plants supplying energy to a node.
                                                                        \nINPUTS
                                                                        \n`Names:` Identifies the specific plant.
                                                                        \n`a:` Plants operating costs are modeled as a quadratic equation, this is the quadratic term constant.
                                                                        \n`b:` This is the linear term constant.
                                                                        \n`k:` This is the constant parameter.
                                                                        \n`p.min:` The minimum operating power of the given plant.
                                                                        \n`p.max:` The maximum operating power of the given plant.
                                                                        \nOUTPUTS
                                                                        \n`power:` The current operating power calculated for the load at this plant.
                                                                        \n`cost:` Cost of the current operation.
                                                                        \n`Rate:` cost/power or $/MW.
                                                                        \n`Incremental cost:` The cost for changing the power by 1 MW in the current setting.
                                                                                       "
                                             )
                                             ),
                                             "</small></p>"),


                                    hr(),
                                        HTML('<table border ="0" width="80%">
                                            <tr><td><font color= "#999999">Code by <b>Luis E Castro</b></td>
                                            <td><a href="mailto:luis.quiros@gmail.com"><img src="gmail.gif"></a>&nbsp;</td>
                                            <td><a href=https://twitter.com/luis_lundquist><img src="twitter.png"></a>&nbsp;</td> 
                                            <td><a href=https://linkedin.com/in/luisquiros><img src="linkedin.gif"></a>&nbsp;</td>
                                            <td><a href=https://github.com/luisecastro><img src="github.png"></a>&nbsp;</td></tr></table>
                                            ')
                                            )
                                        )
                                    ),
                            column(8,
                                   hr(),
                                   span(dataTableOutput('table')))
                            )),
                    tabPanel("Load Profiles",
                             fluidRow(
                                 column(4,
                                        wellPanel(
                                            h4("Expected Electric Load"),
                                            helpText("Generation Dispatch"),
                                            hr(),
                                            wellPanel(
                                                HTML('<small><p align="justify"',
                                                     markdownToHTML(fragment.only=TRUE, text=c("A load profile is `generated randomly` each time the app runs, this load is then analyzed
                                                                                                 by the algorithm in order to minimize the cost of generation given each plant characteristics
                                                                                                 and the requested load for a particular hour.
                                                                                                \n`The first plot` shows the generation profile for each of the plants, 8 in total, along the day.
                                                                                                \n`The second plot` shows the combined generation of all plants to reach the power requested by the load.
                                                                                                \nLoad allocation is calculated using `Lagrange Multipliers` and taking into account the min and max generation capacities of the plants, selecting first the plants with the lowest `incremental cost.`
                                                                                               
                                                          
                                                                                               "
                                             )
                                             ),
                                             "</small></p>"),


                                    hr(),
                                        HTML('<table border ="0" width="80%">
                                            <tr><td><font color= "#999999">Code by <b>Luis E Castro</b></td>
                                             <td><a href="mailto:luis.quiros@gmail.com"><img src="gmail.gif"></a>&nbsp;</td>
                                             <td><a href=https://twitter.com/luis_lundquist><img src="twitter.png"></a>&nbsp;</td> 
                                             <td><a href=https://linkedin.com/in/luisquiros><img src="linkedin.gif"></a>&nbsp;</td>
                                             <td><a href=https://github.com/luisecastro><img src="github.png"></a>&nbsp;</td></tr></table>
                                             ')
                                            )
                                        )
                                    ),
                            column(8,
                                   hr(),
                                   span(plotOutput('plot1')),
                                   span(plotOutput('plot2')))
                            )),
                    tabPanel("Load Calculation",
                             fluidRow(
                                 column(4,
                                        wellPanel(
                                            h4("Regression Analysis"),
                                            helpText("Factors"),
                                            hr(),
                                            wellPanel(
                                                HTML('<small><p align="justify"',
                                                     markdownToHTML(fragment.only=TRUE, text=c("Several factors affect the electricity demand, time of the day, day of the week, month, temperature, processess by big consumers among others.
                                                                                                \nBeing able to analyze the records of previous years, it is posible to make a forecast of the coming days, preparing and optimizing plant allocation, program maintenance and overall reducing costs while efficiently and reliably supplying electric energy to the consumers.
                                                                                                \nTo do this, many statistical and computational tools can be used, in particular regression analysis. Regression analysis is a tool to predict continuous values based in a traing dataset, that is, in this case the log of demanded energy along with relevant prediction parameters.
                                                                                                \nWith a generated, toy dataset, `linear regression` is used to predict the values. The better this is done, the lower the costs will be.
                                                                                                \nThe functions used to generate the dataset along with the code can be consulted at Github.
                                                                                                \n

                                                                                                \n
                                                                                                \nDemand depends on many things, one of them being the square of the temperature, which can be appreciated in the colors of the plots.
                                                                                                \nThe first plot shows the dataset, small spikes were added to account for weekends.
                                                                                                \nThe second one shows a plot of the predictions made with linear regression on the dataset, and ideal prediction would have a clean perfect 45 degree.
                                                                                               \nThe `parameters` used for regression where `Temperature,` `Month,` `Weekday,` and `Hour` of the day.
                                                                                               "
                                                     )
                                                     ),
                                                     "</small></p>"),
                                                
                                                
                                                hr(),
                                                HTML('<table border ="0" width="80%">
                                                     <tr><td><font color= "#999999">Code by <b>Luis E Castro</b></td>
                                                     <td><a href="mailto:luis.quiros@gmail.com"><img src="gmail.gif"></a>&nbsp;</td>
                                                     <td><a href=https://twitter.com/luis_lundquist><img src="twitter.png"></a>&nbsp;</td> 
                                                     <td><a href=https://linkedin.com/in/luisquiros><img src="linkedin.gif"></a>&nbsp;</td>
                                                     <td><a href=https://github.com/luisecastro><img src="github.png"></a>&nbsp;</td></tr></table>
                                                     ')
                                                )
                                                )
                                                ),
                                 column(8,
                                        hr(),
                                        span(plotOutput('plot4')),
                                        hr(),
                                        span(plotOutput('plot3'))

                                                ))
                    
                    
                    )
                    
                    
                    
                    
                )
            )

            )
        )
