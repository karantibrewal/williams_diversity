getMainTab <- function()
{
  tabPanel("Main",
           div(
             class = "smooth",
             tags$head(# Include custom CSS
               includeCSS("main.css")),
             p(img(src='wdplogo.png', width = "500px"), align = "center", style = 'margin-top: -100px; margin-bottom: -70px'),
             p(id = "p1",
               "This project began with a simple yet elusive question - ",
               strong("What is diversity?"),
               "While college admissions brochures and
               statistics constantly boast the College’s diversity like a badge of honor,
               there seems to be no clear understanding of what diversity should look like
               beyond the numbers. While diversity is generally thought of in terms of admissions,
               this project attempts to investigate diversity as it has physically manifested at
               Williams College."
             ),
             br(),
             br(),
             p(id = "p2",
               em(
                 "“The Office of Institutional Diversity and Equity at
                 Williams College dedicates itself to a community where all
                 members can thrive. We work to eliminate harmful bias and discrimination,
                 close opportunity gaps, and advance critical conversations and initiatives
                 that promote inclusion, equity, and social justice on campus and beyond.”"
               ),
               div(id = "p3", "-Williams College Office of Diversity and Equity")
               ),
             br(),
             br(),
             p(
               h3(class = "contact", "Contact"),
               div(class = "contact", "Gabriella Carmona: ", code("gnc1@williams.edu")),
               div(class = "contact", "Arjun Kakkar: ", code("ak23@williams.edu")),
               div(class = "contact", "Karan Tibrewal", code("kt3@williams.edu")),
               div(class = "contact", "Tarun Yadav", code("ty2@williams.edu"))
             )
           ))
}