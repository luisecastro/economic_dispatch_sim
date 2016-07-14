source("global.R")
shinyServer(function(input, output, session){
    
    output$textual <- renderPrint({input$text})
    
    selectedData <- reactive({
        eco_disp(data,input$pt)
    })

    output$table <- renderDataTable({
        selectedData()
    })
    
    result <- profile(data,loader()[,1])


    
    output$plot1 <- reactivePlot(function(){
        p1 <- ggplot(result,aes(x=hour,y=power,color=names,fill=names))+
            geom_bar(stat="identity")+theme_bw()+theme(legend.position="right")+
            ggtitle("Load profile by Plant")+xlab("Load in MW")+ylab("Hour of Day")+
            facet_grid(.~names)
        print(p1)
    })
    
    output$plot2 <- reactivePlot(function(){
        p2 <- ggplot(result,aes(x=hour,y=power,color=names,fill=names))+
            geom_bar(stat="identity")+theme_bw()+theme(legend.position="right")+
            ggtitle("Load profile by hour")+xlab("Load in MW")+ylab("Hour of Day")
        print(p2)
    })
    
    output$plot4 <- reactivePlot(function(){
        p4 <- ggplot(demand,aes(x=days,y=demand,color=temp))+geom_point()+
            theme_bw()+theme(legend.position="right")+
            ggtitle("Demand per Day over a year")+xlab("Day of the year")+ylab("Load in MW")
        print(p4)
    })
    
    output$plot3 <- reactivePlot(function(){
        p3 <- ggplot(demand,aes(x=demand,y=lm1,color=temp))+geom_point()+
            theme_bw()+theme(legend.position="right")+
            ggtitle("Prediction vs Observation")+xlab("Observation")+ylab("Prediction")
        print(p3)
    })
    
    
})



    
