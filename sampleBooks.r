# sample books of users


for (id in userid[-100:-1]) {
  user.book <- rbind(user.book, getUserBook(id))
  print(nrow(user.book))
}

save(user.book, file="userbook0")
