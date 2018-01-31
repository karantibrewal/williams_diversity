#' Function to get map tab
#' @return a tabPanel object with interactive map to display social graph with
#'         probabilities of "clustering" across demographics like race, athelete-status,
#'         majors, etc.
getContactTab <- function()
{
  tabPanel("Contact",
           div(p(style = "margin-top:200px;",
             h3(class = "contact", "Contact"),
             div(class = "contact", "Gabriella Carmona: ", code("gnc1@williams.edu")),
             div(class = "contact", "Arjun Kakkar: ", code("ak23@williams.edu")),
             div(class = "contact", "Karan Tibrewal", code("kt3@williams.edu")),
             div(class = "contact", "Tarun Yadav", code("ty2@williams.edu"))
           )))
}