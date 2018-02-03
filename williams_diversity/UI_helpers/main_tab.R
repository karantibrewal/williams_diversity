getMainTab <- function()
{
  tabPanel("Main",
           id = "main",
           div(
             class = "parallax-img-container",
             class = "smooth",
             tags$head(# Include custom CSS
               includeCSS("main.css"),
               includeScript("parallaxImg.js"),
               includeScript("scroll.js")
             ),
             div(
               img(src = 'wdplogo.png', width = "500px"),
               align = "center",
               style = 'margin-top: -90px; margin-bottom: -70px;'
             ),
             # img(src='https://www.istockphoto.com/resources/images/PhotoFTLP/img_63351521.jpg', 
             #     class='parallax-move', 
             #     `data-ps-z-index`="1", 
             #     `data-ps-speed`="1", 
             #     `data-ps-vertical-position`="3700", 
             #     `data-ps-horizontal-position`="0"),
             p(
               id = "p1",
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
             p(
               id = "p2",
               em(
                 "“The Office of Institutional Diversity and Equity at
                 Williams College dedicates itself to a community where all
                 members can thrive. We work to eliminate harmful bias and discrimination,
                 close opportunity gaps, and advance critical conversations and initiatives
                 that promote inclusion, equity, and social justice on campus and beyond.”"
               ),
               div(id = "p3", "-Williams College Office of Diversity and Equity")
               )
             # ,
             # br(),
             # br(),
             # br(),
             # br(),
             # div(class = "row", style = "padding-left:150px;padding-right:150px;",
             #     div(class = "column", 
             #         p(h3("Diversity:"),
             #           h5("/dəˈvərsədē,dīˈvərsədē/"), 
             #           "the state of being diverse; variety")),
             #     div(class = "column", 
             #         p(h3("Equity:"),
             #           h5("/ˈekwədē/"), 
             #           "the quality of being fair and impartial")),
             #     div(class = "column", 
             #         p(h3("Inclusion:"),
             #           h5("/inˈklo͞oZHən/"), 
             #           "the action or state of including or of being included within a group or structure"))
             #   
             # )
            
             ))
}