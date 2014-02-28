---
layout: post
title: "Creative Commons Lizenzen und Open Access Journals – ein Vorschlag zugunsten der Nachvollziehbarkeit"
date: 2014-02-12 18:14
comments: true
categories: 
- DOAJ
- Open Access
- Executable Papers
- R
---

> vielleicht von Interesse, ich habe eine kleine Auswertung über die Verbreitung von CC-Lizenzen unter den Journals des Directory of Open Access Journals erstellt, 

http://www.scinoptica.com/pages/topics/creative-commons-lizenzen-und-open-access-journals.php

Die obige Exploration fand über das manuelle Übertragen von Suchergebnissen aus dem DOAJ in eine Tabellenkalkulation statt.

Geeigneter im Sinne der Nachvollziehbarkeit sowie der Demonstration des Mehgrwertes offener Schnittstellen ist sicherlich

* das direkte Arbeiten mit den Zeitschriftentiteldaten des DOAJ. Diese können [direkt heruntergeladen werden](http://www.doaj.org/faq#metadata)
* sowie deren Auswertung als "executable paper" 

Am Beispiel mit R lassen sich die Daten wie folgt einlesen:


```r
my.data <- read.csv("http://www.doaj.org/doaj?func=csv", header = TRUE, sep = ",")
```


Die erfassten Eigenschaften der DOAJ Journale:

```r
names(my.data)
```

```
##  [1] "Title"               "Title.Alternative"   "Identifier"         
##  [4] "Publisher"           "Language"            "ISSN"               
##  [7] "EISSN"               "Keyword"             "Start.Year"         
## [10] "End.Year"            "Added.on.date"       "Subjects"           
## [13] "Country"             "Publication.fee"     "Further.Information"
## [16] "CC.License"          "Content.in.DOAJ"
```


sowie deren Anzahl


```r
dim(my.data)
```

```
## [1] 9804   17
```


Die Verteilung der Nutzung lässt sich wie folgt erstellen:


```r
table(my.data$CC.License)
```

```
## 
##                by    by-nc by-nc-nd by-nc-sa    by-nd    by-sa 
##     6082     1964      665      737      260       44       52
```


Journale, für die eine CC Lizenz verzeichnet sind:

```r
nrow(my.data[!my.data$CC.License == "", ])
```

```
## [1] 3722
```


in Prozent:


```r
nrow(my.data[!my.data$CC.License == "", ])/nrow(my.data) * 100
```

```
## [1] 37.96
```


Die vollständige prozentuale Verteilung der Lizenzen:

```r
prop.table(table(my.data$CC.License)) * 100
```

```
## 
##                by    by-nc by-nc-nd by-nc-sa    by-nd    by-sa 
##  62.0359  20.0326   6.7829   7.5173   2.6520   0.4488   0.5304
```


Nach [Open Definition](http://opendefinition.org/) 


```r
my.data$CC.BY <- my.data$CC.License %in% c("by", "by-sa")
table(my.data$CC.BY)
```

```
## 
## FALSE  TRUE 
##  7788  2016
```


### ... und noch mehr Möglichkeiten

z.B Verlage mit den meisten Journalen (Top 6).

```r
head(sort(table(my.data$Publisher), decreasing = TRUE))
```

```
## 
## Hindawi Publishing Corporation                 BioMed Central 
##                            439                            240 
## Scientific Research Publishing                   Bentham open 
##                            119                            100 
##                       Springer                        MDPI AG 
##                             96                             95
```


oder das Wachstum des DOAJ


```r
require(ggplot2)
```

```
## Loading required package: ggplot2
```

```r

my.data$Added.Year <- (as.Date(my.data$Added.on.date, format = "%Y-%m-%d"))
date.doaj <- as.data.frame(table(unlist(my.data$Added.Year)))
cum <- cumsum(date.doaj$Freq)
date.doaj <- cbind(date.doaj, cum)

ggplot(date.doaj, aes(as.Date(Var1), cum)) + geom_line(colour = "blue") + xlab("Date added to DOAJ") + 
    ylab("Cumulative Sum")
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-10.png) 

