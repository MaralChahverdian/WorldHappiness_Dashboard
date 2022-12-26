library(ggplot2)
library(ggthemes)
library(dplyr)
library(maps)
library(googleVis)
library(shiny)
library(plotly)
library(corrplot)
library(cluster)
library(formattable)
library(DT)
happiness5<-read.csv("2015.csv",stringsAsFactors = F)


happiness6<-read.csv("2016.csv",stringsAsFactors = F)
reg1<-lm(Happiness.Score~Freedom+Economy..GDP.per.Capita.+Health..Life.Expectancy.,data = happiness5)

