# sample more than maxUser users

userid <- 45921938
userpool <- numeric(0)
maxUser <- 100000
while (length(userid) < maxUser) {
  try( {
    id <- userid[sample(length(userid), 1)]
    if (id %in% userpool) {
      next()
    }
    userpool <- c(userpool, id)
    groupid <- unique(getUserGroup(id))
    userid <- unique(c(userid, getGroupUser(groupid)))
    print(length(userid))
  }, silent = TRUE)
}
save(userid, file = "userid")
