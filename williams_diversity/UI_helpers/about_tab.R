getAboutTab <- function()
{
  tabPanel("About",
           column(2, p("")),
           column(
             8,
             p(
               div(
                 em(
                   "“The Office of Institutional Diversity and Equity at
                   Williams College dedicates itself to a community where all
                   members can thrive. We work to eliminate harmful bias and discrimination,
                   close opportunity gaps, and advance critical conversations and initiatives
                   that promote
                   inclusion, equity, and social justice on campus and beyond.”"
                 ),
                 style = "font-size:18px; text-align:justify; padding-right:60px; padding-left:60px"
                 ),
               div("-Williams College Office of Diversity and Equity",
                   style = "font-size:14px; text-align:right; padding-right:60px")
               ),
             br(),
             br(),
             p(
               "This project began with one single yet elusive question - ",
               strong("What is diversity?"),
               "While college admissions brochures and
               statistics constantly boast a College’s diversity like a badge of honor,
               there seems to be no clear understanding of what diversity should look like
               beyond the numbers. While diversity is generally thought of in terms of admissions,
               this project attempts to investigate diversity as it has physically manifested at
               Williams College.",
               style = "font-size:18px; text-align:justify; padding-right:40px; padding-left:40px"
             ),
             br(),
             br(),
             p(
               h3("Contact"),
               div("Gabriella Carmona: ", code("gnc1@williams.edu")),
               div("Arjun Kakkar: ", code("ak23@williams.edu")),
               div("Karan Tibrewal", code("kt3@williams.edu"))
             )
               ))
}