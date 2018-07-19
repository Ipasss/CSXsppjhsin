library(readr)
raw <- read_csv("Documents/GitHub/CSXsp/Week3/Womens Clothing E-Commerce Reviews.csv")

raw %>%
  group_by(`Clothing ID`) %>%
  summarise(Count = n()) %>%
  arrange(desc(Count)) %>%
  ungroup() %>%
  mutate(clothid = reorder(`Clothing ID`,Count)) %>%
  head(10) %>%
  ggplot(aes(x = clothid, y = Count)) +
  geom_bar(stat='identity',colour="white", fill = "orange") +
  geom_text(aes(x = clothid, y = 1, label = paste0("(",Count,")",sep="")),
            hjust=0, vjust=.5, size = 4, colour = 'black',
            fontface = 'bold') +
  labs(x = 'ID of Cloth', 
       y = 'Count', 
       title = 'Clothing ID and Count') +
  coord_flip() +
  theme_bw()

library(ineq)
x <- table(raw$`Clothing ID`)
lc.cloth <- Lc(x)
g.cloth <- ineq(x)
# create data.frame from LC
p <- lc.cloth[1]
L <- lc.cloth[2]
df <- data.frame(p,L)

# plot
ggplot(data = df) +
  geom_line(aes(x = p, y = L), color="red") +
  scale_x_continuous(name="Cumulative share of X", limits=c(0,1)) + 
  scale_y_continuous(name="Cumulative share of Y", limits=c(0,1)) +
  geom_abline() +
  labs(title = paste("Concentration of Clothings in data (Gini:", round(g.cloth, 2), ")"))

top.ten <- as.data.frame(head(sort(table(raw$`Clothing ID`), decreasing = TRUE), 10))
d <- raw[raw$`Clothing ID` %in% top.ten$Var1,]

histogram(~Age|factor(`Clothing ID`), data = d, col = "orange",
          main = "Distribution of Age for top ten Clothings", xlab = "Age")

bwplot(~Rating|factor(`Clothing ID`), data = d, col = "orange", 
       main  = "Ratings for top ten Clothings", xlab = "Rating")

bwplot(factor(Rating) ~ Age|factor(`Division Name`) + factor(`Recommended IND`), 
       data = raw, xlab = "Age", main = "Age, Rating and Recommendation status")

xyplot(factor(Rating) ~ Age|factor(`Division Name`), groups = factor(`Recommended IND`),
       data = raw)

bwplot(Rating ~ factor(`Recommended IND`)|factor(`Division Name`),
       data = raw)

raw %>% 
  unnest_tokens(word, `Review Text`) %>% 
  anti_join(stop_words) %>% 
  count(word, sort = TRUE) %>%
  head(10) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col() +
  labs(x = NULL, title = "Most used words in Reviews") +
  coord_flip()

raw %>% 
  unnest_tokens(word, `Review Text`) %>% 
  anti_join(stop_words) %>% 
  count(word, Rating, sort = TRUE) %>%
  select(n, word, Rating) %>%
  group_by(Rating) %>% 
  top_n(n = 5, wt = n) %>% 
  ggplot(aes(word, n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip() +
  facet_grid(. ~ Rating)

by.rating.word <- as.data.table(raw %>% 
                                  unnest_tokens(word, `Review Text`) %>% 
                                  anti_join(stop_words) %>% 
                                  count(word, Rating, sort = TRUE))

by.pct.word <- by.rating.word[, gr.pct := n/sum(n), by = Rating]

by.rating.word %>% 
  group_by(Rating) %>% 
  top_n(n = 5, wt = gr.pct) %>% 
  ggplot(aes(word, (gr.pct*100))) +
  geom_col(aes(fill = (gr.pct*100))) +
  xlab(NULL) +
  ylab("Pct. per Rating") +
  theme(axis.text.x = element_text(angle=90, vjust=0.5)) +
  scale_fill_gradient(low = "lightblue", high = "darkblue", name = "Pct.") +
  coord_flip() +
  facet_grid(. ~ Rating)

rate.cols <- c("#d7191c", "#fdae61", "#fc8d59", "#a6d96a", "#1a9641")
by.rating <- as.data.table(raw %>% 
                             unnest_tokens(bigram, `Review Text`, token = "ngrams", n = 2) %>% 
                             separate(bigram, c("word1", "word2"), sep = " ") %>% 
                             filter(!word1 %in% stop_words$word) %>%
                             filter(!word2 %in% stop_words$word) %>% 
                             unite(bigram.unite, word1, word2, sep = " ", remove = FALSE) %>% 
                             count(bigram.unite, Rating, sort = TRUE))

by.pct <- by.rating[, gr.pct := n/sum(n), by = Rating]

by.rating %>% 
  group_by(Rating) %>% 
  top_n(n = 40, wt = gr.pct) %>% 
  acast(bigram.unite ~ Rating, value.var = "gr.pct", fill = 0) %>%
  comparison.cloud(title.size = 1, random.order = TRUE,
                   colors = rate.cols)

each.wordcloud <- by.rating %>% 
  group_by(Rating) %>% 
  top_n(n = 50, wt = gr.pct)

opar <- par()
par(mfrow = c(3,2), mar = c(rep(0.5, 4)))
for (cc in 1:5){
  each.wordcloud %>% 
    filter(Rating == cc) %>% 
    with(wordcloud(bigram.unite, n, scale = c(5,0.2), colors = rate.cols[cc]))
  title(paste("Rating:", cc), cex = 0.5, col = rate.cols[cc])
}
par(opar)