library(ggplot2)

# analyze user.book data
load("userbook0")

# review counts by year/month/day
rc <- aggregate(user.book["reviews_count"], by=list(month = user.book$pubmonth), FUN=sum)
nb <- aggregate(user.book["bookid"], by=list(month = user.book$pubmonth), function(x) {length(unique(x))})
review.month <- merge(rc, nb)
colnames(review.month)[3] <- "numbooks"
review.month$month <- as.factor(review.month$month)
review.month$reviews_per_book <- review.month$reviews_count / review.month$numbooks
ggplot(review.month, aes(x = month, y = reviews_per_book)) +
  geom_bar(stat = "identity")

# fraction of users engaged by publisher
user.publisher <- aggregate(user.book["userid"], by=list(publisher = user.book$publisher), function(x) {length(unique(x))})
colnames(user.publisher)[2] <- "numusers"
user.publisher$fracuser <- user.publisher$numusers/ length(unique(user.book$userid)) * 100
user.publisher <- user.publisher[order(-user.publisher$numusers),]
topPub <- user.publisher[2:13,]
topPub$publisher <- factor(as.character(topPub$publisher), levels = as.character(topPub$publisher))
ggplot(topPub, aes(x = publisher, y = fracuser)) +
  geom_bar(stat = "identity") +
  ylab("User Engaged %") +
  xlab("Publisher") +
  theme(axis.text.x=element_text(angle = 45, hjust=1))
