getDataAndAnalysisTab <- function()
{
  tabPanel(
    "Data and Analysis",
    h3("Data"),
    p(
      "The data for this project was obtained from various sources that are all
      accessible to Williams students. The building rosters for on-campus
      housing are available",
      a("here", href = "https://williams.starrezhousing.com/StarRezPortal/Default.aspx?Params=L9ezxPcQnQuRGKTzF%2b4sxeNblvAA%2b26c"),
      "using a Williams College login. This data was then merged with
      class year data using a list of all students obtained from",
      a("WSO.", href = "https://wso.williams.edu/facebook"),
      "The ethnic/racial
      classifications were done using the 2010 US census data on last names. For
      those ethnic groups for which the last name did not provide a strong signal
      for classification, the assignment was done by hand.
      The combined dataset consists of 1653 students. 197 students were removed
      from the original dataset since no match for their lastname was found.
      Assuming that the number of last names without matches are proportional
      in terms of ethnicity, the analysis conducted here would not have an
      unreasonable amount of error."
    ),
    h3("Analysis"),
    p(
      "The compiled data was analysed by looking at proportional representation
      accross class years and campus locations. As an example the following plot
      visualizes the representation of ethnic groups for all years accross different
      student housing on campus."
    ),
    plotOutput("allbar"),
    p(
      "Statistical significance for a difference between each of these proportions and the
      overall proportions of the college community was calculated using 4-sample test for
      equality of proportions. The p-values obtained using this test were used to color the
      nodes in the map. 'Super unlikely' corresponds to a p-value between 0-0.05, 'very unlikely'
      corresponds to a p-value between 0.05-0.1, 'unlikely' corresponds to a p-value between
      0.1-0.3 and the rest is designated as 'likely'."
    ),
    h3("Anonymized Raw Data"),
    p(
      "The raw data used to construct the interactive graphics and
      conduct the statistical analysis is presented as follows. It
      can be downloaded by simply copying the table. The names of
      students have been removed in order to protect sensitive
      information. For any additional information, questions or
      concerns about the dataset, please contact the authors."
    ),
    dataTableOutput("raw_data")
    )
}