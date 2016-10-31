setwd("~/Documents/BookPop")
# sample books of users

start.time <- Sys.time()

user.book2 <- data.frame()

for (id in userid2) {
  user.book2 <- rbind(user.book2, getUserBook(id))
  print(nrow(user.book2))
}

print(Sys.time() - start.time)

save(user.book2, file = "userbook2")
