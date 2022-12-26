shinyServer(
  function(input, output,session) {
    output$myPlot <- renderPlot({
      
      
      if(input$dataset1=="2015"){
        happiness<-happiness5
      }
      else{
        happiness<-happiness6
        
      }
      
    
      
      continent <- input$region1

      datas<-filter(happiness,Region==continent)
      
      if(continent=="All"){
        gg<-ggplot(happiness,aes(x=Happiness.Score,y=Generosity))+geom_smooth()
       ## gg<-gg+geom_point(data=happiness,aes(x = Happiness.Score, y = Generosity, shape = Country))
        gg<-gg+theme_gdocs()
        gg<-gg+ggtitle("Happiness Score - Generosity")
        gg
      }
    else{
      gg<-ggplot(datas,aes(x=Happiness.Score,y=Generosity))+geom_smooth()
      gg<-gg+geom_point(data=datas,aes(x = Happiness.Score, y = Generosity, shape = Country))
      gg<-gg+theme_gdocs()
      gg<-gg+ggtitle("Happiness Score - Generosity")
      gg
    }
      
      
    })
    output$myPredict <- renderPlot({
      
      if(input$dataset2=="2016"){
        happiness<-happiness6
      }
      if(input$dataset2=="2015"){
        happiness<-happiness5
        
      }
     
     
      reg1<-lm(Happiness.Score~Freedom+Economy..GDP.per.Capita.+Health..Life.Expectancy.,data = happiness)
      ##summary(reg1)
      qplot(Happiness.Score,predict(reg1),data = happiness,xlab = "Reality",ylab = "Prediction" )+geom_smooth()
      
      
    })
    
    
    output$geomText <- renderPlot({
      
      if(input$dataset3=="2015"){
        happiness<-happiness5
      }
      if(input$dataset3=="2016"){
        happiness<-happiness6
        
      }
      continent <- input$region3
      
      datas<-filter(happiness,Region==continent)
      
      
      min_y<-min(happiness$Happiness.Score)
      max_y<-max(happiness$Happiness.Score)
      min_x<-min(happiness$Freedom)
      max_x<-max(happiness$Freedom)
      sub<-subset(datas, Freedom<=min_x|Freedom>=max_x|Happiness.Score<=min_y|Happiness.Score>=max_y)
      
      g_text<-ggplot()+scale_y_continuous(limits=c(min_y, max_y)) 
      g_text<-g_text+geom_point(data=datas, aes(x=Freedom, y=Happiness.Score, fill=Country), size=9, shape=21, color="black") 
      
      g_text<-g_text+geom_text(data=datas, aes(x=Freedom, y=Happiness.Score, label=substr(Country, 1, 1)), size=6) 
      
      g_text<-g_text+geom_text(data=sub, aes(x=Freedom, y=Happiness.Score, label=Happiness.Rank), size=4, vjust=3, hjust=0.5) 
      g_text<-g_text+theme_economist()
      g_text
    
      
    })
    output$googlemap <- renderPlot({
      
      if(input$dataset4=="2015"){
        input<-happiness5
      }
      else{
        input<-happiness6
        
      }
      
      
      
      library(googleVis)
      
      Map <- data.frame(input$Country,input$Happiness.Rank)
      names(Map)<-c("Country","Happines-Rank")
      Geo=gvisGeoMap(Map,locationvar = "Country",numvar ="Happines-Rank",options =list(height=159,dataMode='regions'))
      plot(Geo)
      
      
      
    })
    output$data<-renderFormattable({
     
      df1<-merge(happiness5[,c(1,3)],
                 happiness6[,c(1,3)],
                 by.x = "Country",
                 by.y = "Country")
      colnames(df1)<-c("Country","Happiness Rank 2015","Happiness Rank 2016")
      df1<-df1%>%
        mutate(`Rank Change`=`Happiness Rank 2015`-`Happiness Rank 2016`)
      
      
      formattable(df1,list(
        `Rank Change` = formatter(
          "span",
          style=~formattable::style(color=ifelse(`Rank Change`>0,"green","red")))))
      
    
      
    },env = parent.frame(), quoted = FALSE)
    output$summary<-renderText({
      
     
      "Linear Regresion done based on significant variables
     Residuals:
       Min       1Q   Median       3Q      Max 
     -1.45041 -0.32831  0.04875  0.39986  1.36878 
     
     Coefficients:
       Estimate Std. Error t value Pr(>|t|)    
     (Intercept)                2.5171     0.1501  16.766  < 2e-16 ***
       Freedom                    2.4280     0.3457   7.023 6.67e-11 ***
       Economy..GDP.per.Capita.   1.1640     0.2095   5.557 1.19e-07 ***
       Health..Life.Expectancy.   1.5315     0.3737   4.098 6.73e-05 ***
       ---
      Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
     
     Residual standard error: 0.584 on 153 degrees of freedom
     Multiple R-squared:  0.7434,	Adjusted R-squared:  0.7383 
     F-statistic: 147.7 on 3 and 153 DF,  p-value: < 2.2e-16"
     
     
    })
    output$predScore<-renderText({
      if(input$dataset2=="2016"){
        happiness<-happiness6
      }
      if(input$dataset2=="2015"){
        happiness<-happiness5}
      country<-input$country
      freedom<-happiness[happiness$Country==country,9]
      freedom<-as.numeric(freedom)
      gdp<-happiness[happiness$Country==country,6]
      gdp<-as.numeric(gdp)
      health<-happiness[happiness$Country==country,8]
      health<-as.numeric(health)
      offs<-2.5171
      offs<-as.numeric(offs)
      pred<-offs+2.4280*freedom+1.1640*gdp+1.5315*health
      pred
      
      
      
    })
    output$realScore<-renderText({
     
        if(input$dataset2=="2016"){
          happiness<-happiness6
        }
        if(input$dataset2=="2015"){
          happiness<-happiness5
          
        }
      country<-input$country
      x<-happiness[happiness$Country==country,4]
      x
      
      
      
    })
    output$tride<-renderPlotly({
      
      if(input$datasetPlotly=="2016"){
        happiness<-happiness6
      }
      if(input$datasetPlotly=="2015"){
        happiness<-happiness5
        
      }
      
      plot_ly( happiness, x=~Happiness.Score, y=~Freedom, z=~Economy..GDP.per.Capita., 
               marker=list(color=~Happiness.Score,colorscale=c('#FFE1E1', '#683531'), showscale=TRUE))
      
      
    })
    output$boxes<-renderPlotly({
      
      if(input$datasetBox=="2016"){
        happiness<-happiness6
      }
      if(input$datasetBox=="2015"){
        happiness<-happiness5
        
      }
      
      plot_ly(happiness,x=~Region,
              y=~Happiness.Score,
              type="box",
              boxpoints="all",
              pointpos = -1.8,
              color=~Region)%>%
        layout(xaxis=list(showticklabels = FALSE),
               margin=list(b = 100))
      
      
    })
   
    output$correl<-renderPlot({
      
      if(input$dataset2=="2016"){
        happiness<-happiness6
      }
      if(input$dataset2=="2015"){
        happiness<-happiness5
        
      }
      
      test<-cor(as.matrix(happiness[,-c(1,2,3)]))
      
      corrplot::corrplot(test,method = "square",type = "upper",mar = c(0,0,1,0))
      
      
    })
    output$clust<-renderPlot({
      
      if(input$datasetClust=="2016"){
        happiness<-happiness6
      }
      if(input$datasetClust=="2015"){
        happiness<-happiness5
        
      }
      
     # set.seed(20)
      clu<-kmeans(happiness[ , 6:7 ], 10, nstart = 20)
      clu
      
      table(clu$cluster, happiness$Region)
      
      clu$cluster <- as.factor(clu$cluster)
      x <- tapply(happiness$Economy..GDP.per.Capita.,clu$cluster,mean)
      y <- tapply(happiness$Family,clu$cluster,mean)
      kcenters <- data.frame(x,y)
      
      
      plot_clu<-ggplot(cbind(happiness, cluster=factor(clu$cluster)))
      plot_clu<-plot_clu+  geom_point(aes(x=Economy..GDP.per.Capita.,y=Family, col=cluster),size=2) 
      plot_clu<-plot_clu+geom_point(data=cbind(kcenters, cluster=factor(1:nrow(kcenters))),aes(x,y, col=cluster),pch=8,size=9)
      plot_clu<-plot_clu+ggtitle("K-means Clustering")
      plot_clu
      
      
      
    })
    
    
    
   
  })