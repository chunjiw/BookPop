setwd("~/Documents/BookPop")
# sample books of users

start.time <- Sys.time()

user.book4 <- data.frame()

for (id in userid4) {
  user.book4 <- rbind(user.book4, getUserBook(id))
  print(nrow(user.book4))
}

print(Sys.time() - start.time)


