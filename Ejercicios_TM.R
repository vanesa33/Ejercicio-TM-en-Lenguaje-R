## Cargo las librerias
library(tm)
library(wordcloud)
library(rtext)

## creo el corpus
docs <- Corpus(DirSource("C:/Users/Layla Scheli/Desktop/Docencia/BA Emprende/Programa en Ciencia de Datos/6. Clase/Ejercicio_TM/Datos textos/Libros"))

## limpio el corpus
toSpace <- content_transformer(function(x, pattern) {return (gsub(pattern, " ", x))})

docs <- tm_map(docs, toSpace, "-")
docs <- tm_map(docs, toSpace, ":")
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, toSpace, "´")
docs <- tm_map(docs, toSpace, "`")
docs <- tm_map(docs, toSpace, "-")
docs <- tm_map(docs,content_transformer(tolower))
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, removeWords, stopwords("english"))
docs <- tm_map(docs, removeWords, stopwords("spanish"))
docs <- tm_map(docs, stripWhitespace)

## construyo la matriz de textos por documentos
dtm <- DocumentTermMatrix(docs)
freq <- colSums(as.matrix(dtm))
ord <- order(freq,decreasing=TRUE)

## Wordcloud
freq2 <- freq[which(freq>=200)]
wordcloud(names(freq2),freq2)
