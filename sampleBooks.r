# sample books of users
start.time <- Sys.time()
user.book1 <- getUserBook(userid[1:100])
end.time <- Sys.time()
print(end.time - start.time)


user.book2 <- getUserBook(userid[1:100 + 100])
user.book3 <- getUserBook(userid[1:100 + 200])
user.book4 <- getUserBook(userid[1:100 + 300])
user.book5 <- getUserBook(userid[1:100 + 400])
user.book6 <- getUserBook(userid[1:100 + 500])
user.book7 <- getUserBook(userid[1:100 + 600])
user.book8 <- getUserBook(userid[1:100 + 700])
user.book9 <- getUserBook(userid[1:100 + 800])
user.book0 <- getUserBook(userid[1:100 + 900])
