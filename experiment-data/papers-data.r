#options(error = recover, warn = 2)
#options(error = function() {traceback(2, max.lines=100); if(!interactive()) quit(save="no", status=1, runLast=T)})
#sink(stdout(), type="message")
#https://stackoverflow.com/questions/7485514/can-you-make-r-print-more-detailed-error-messages
#http://adv-r.had.co.nz/Exceptions-Debugging.html

##################################################
## Project: Comparison of BCI Papers
## Script purpose: Compare Frustration/Fun/Motivation/Control level between BCI papers
## Date: 01/07/2019
## Author: Bastian Ilso
##################################################
library(gsheet)
library(dplyr)
library(ggplot2)

url <- 'docs.google.com/spreadsheets/d/1EU_GgYr4gQ42Eks8QA5KPyyKwED1eQQRSUTx_PspfEM#gid=1516753331'
papers.data <- gsheet2tbl(url)

##Plot Level of Control vs Frustration Level
papers.data %>%
  filter(!is.na(Frustration)) %>%
  group_by(Paper) %>%
  ggplot(aes(x=Control, y=Frustration, color=Paper)) +
  scale_colour_manual(values=c("#D55E00", "#009E73", "#0072B2", "#ad4141", "#ad4141", "#ad4141")) +
  xlim(0,1) +
  ylim(0,1) +
  geom_line(size=1.25) +
  geom_point(size=3.5) +
  theme_bw() +
  theme(text = element_text(size = 12))


##Plot Level of Control vs Fun/Motivation
papers.data %>% mutate(Motivation.Fun = coalesce(Fun, Motivation)) %>%
  filter(!is.na(Motivation.Fun)) %>%
  group_by(Paper) %>%
  ggplot(aes(x=Control, y=Motivation.Fun, color=Paper)) +
  scale_colour_manual(values=c("#D55E00", "#009E73", "#CC79A7", "#0072B2")) + 
  xlim(0,1) +
  ylim(0,1) +
  geom_point() +
  geom_line() 

##Plot Level of Control vs Perceived Control
papers.data %>%
  filter(!is.na(`Perceived Control`)) %>%
  group_by(Paper) %>%
  ggplot(aes(x=Control, y=`Perceived Control`, color=Paper)) +
  scale_colour_manual(values=c("#000000", "#da995fff", "#f6b3b3", "#e79557", "#ad4141", "#da5f5fff", "#009E73", "#0072B2")) + 
  xlim(0,1) + 
  ylim(0,1) +
  #geom_hline(yintercept=1) +
  geom_line(size=1.25) +
  geom_point(size=3.5) +
  theme_bw() +
  theme(text = element_text(size = 12))
  #do({if(.$Papers=="Greville-Causal1R1")})

##Plot Perceived Control vs Frustration
papers.data %>%
  filter(!is.na(`Perceived Control`)) %>%
  group_by(Paper) %>%
  ggplot(aes(x=`Perceived Control`, y=Frustration, color=Paper)) +
  scale_colour_manual(values=c("#000000", "#ad4141", "#f6b3b3", "#e79557", "#009E73", "#ad4141", "#009E73", "#0072B2")) + 
  xlim(0,1) +
  ylim(0,1) +
  geom_line(size=1.25) +
  geom_point(size=3.5) +
  theme_bw() +
  theme(text = element_text(size = 12))