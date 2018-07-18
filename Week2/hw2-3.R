library(NLP)
library(tm)
library(jiebaRD)
library(jiebaR)
library(RColorBrewer)
library(wordcloud)

wk <- worker()

text <- readLines("news.txt", encoding = "UTF-8")

stopwords <- c("的", "與", "在", "和", "會", "是", "我", "都", 
               "來", "要", "們", "一", "第", "他", "有", "而", 
               "了", "這個", "因為", "這些", "也", "她", "但",
               "為", "這", "說", "不", "社", "沒", "什麼", "就"
              )
stopwords.pattern <- paste0(stopwords, sep = "|", collapse = "") %>%
  substr(1, nchar(.) -1)

text <- gsub(stopwords.pattern, " ", text)

seg <- wk[text]

seg <- as.data.frame(table(seg))
freq <- seg[order(seg$Freq, decreasing = T), ]

par(family=("Heiti TC Light"))
wordcloud(freq$seg, freq$Freq,
          min.freq = 2, random.order = F,
          color = brewer.pal(8, "Dark2"))