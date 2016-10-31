shinyServer(function(input, output) {
  
  output$p <- renderPlot({
    
    if (input$radio == 1) {
      ggplot(review.month, aes(x = month, y = reviews_per_book)) +
        geom_bar(stat = "identity")
    } else {
      ggplot(topPub, aes(x = publisher, y = fracuser)) +
        geom_bar(stat = "identity") +
        ylab("User Engaged %") +
        xlab("Publisher") +
        theme(axis.text.x=element_text(angle = 45, hjust=1))
    }
    
    
  })
  
  output$explaintext <- renderText({
    if (input$radio == 1) {
      "This shows how book popularity (measured by number of reviews per book) depends on publication month."
    } else {
      "Popularity of top publishers, ordered by fraction of users engaged"
    }
  })

  
})