getUserGroup <- function(userid, base_path = "https://www.goodreads.com/", 
                         key = "DYNDEHgOTor79cS1Z6w") {
  path <- "group/list"
  groupids <- numeric(0)
  for (id in userid) {
    query = list(id = id, key = key)
    res <- httr::GET(base_path, path = path, query = query )
    con <- content(res, as = "text")
    conp <- xmlParse(con)
    d <- xmlToDataFrame(conp)
    groups <- str_extract_all(d$list[2], "group/show/[0-9]+")
    gids <- as.numeric(str_extract_all(groups, "[0-9]+", simplify = TRUE))
    groupids <- c(groupids, gids) 
  }
  groupids
}

getGroupUser <- function(groupid, base_path = "https://www.goodreads.com/", 
                         key = "DYNDEHgOTor79cS1Z6w") {
  path <- "group/members"
  userids <- numeric(0)
  for (id in groupid) {
    query = list(id = id, key = key)
    # res <- httr::GET(base_path, path = path, query = query)
    res <- httr::GET(paste(base_path, path, sprintf("/%i.xml?key=%s", id, key), sep=""))
    if (httr::http_status(res)$category != "Success"){
      print (paste0(httr::http_status(res)$reason," ",httr::http_status(res)$message))
      next()
    }
    con <- content(res, as = "parsed")
    conp <- xmlParse(con, encoding = "UTF-8")
    gu <- getNodeSet(conp, "//group_user")
    d <- xmlToDataFrame(gu)
    userids <- c(userids, as.numeric(str_extract(d$user, "[0-9]+")))
  }
  userids
}

getUserBook <- function(userid, base_path = "https://www.goodreads.com/", 
                        key = "DYNDEHgOTor79cS1Z6w") {
  path <- "user/show"
  userids <- numeric(0)
  bookids <- numeric(0)
  authorids <- numeric(0)
  pubyear <- numeric(0)
  pubmonth <- numeric(0)
  pubday <- numeric(0)
  numpages <- numeric(0)
  publisher <- character(0)
  lang <- character(0)
  reviews_count <- numeric(0)
  
  for (id in userid) {
    query = list(id = id, key = key)
    res <- httr::GET(base_path, path = path, query = query)
    con <- content(res, as = "parsed")
    conp <- xmlParse(con, encoding = "UTF-8")
    bo <- getNodeSet(conp, "//book")
    d <- xmlToDataFrame(bo)
    idx <- !duplicated(d$id)
    userids <- c(userids, rep(id, times = sum(idx)))
    bookids <- c(bookids, as.numeric(as.character(d$id))[idx])
    authorids <- c(authorids, as.numeric(as.character(d$author_id))[idx])
    pubyear <- c(pubyear, as.numeric(as.character(d$publication_year))[idx])
    pubmonth <- c(pubmonth, as.numeric(as.character(d$publication_month))[idx])
    pubday <- c(pubday, as.numeric(as.character(d$publication_day))[idx])
    numpages <- c(numpages, as.numeric(as.character(d$num_pages))[idx])
    publisher <- c(publisher, as.character(d$publisher)[idx])
    lang <- c(lang, as.character(d$language_code)[idx])
    reviews_count <- c(reviews_count, as.numeric(as.character(d$reviews_count))[idx])
  }
  data.frame(userid = userids, bookid = bookids,
             authorids = authorids,
             pubyear = pubyear,
             pubmonth = pubmonth,
             pubday = pubday,
             numpages = numpages,
             publisher = publisher,
             language = lang,
             reviews_count = reviews_count)
}






