# R_shiny_app_midterm
R Shiny App Istanbul Real Estate Valuation


In this study,  Istanbul province, which in Turkey has the highest population density and represents the economical, historical, and sociocultural center of the country was chosen as an application area. Within the scope of this study, the housing price analysis models have been developed by referring to the advertisements for the sale of flat all over the districts of Istanbul. 

In order to avoid duplications and data inconsistencies that may occur with the same advertisements for different sale prices of flats on different sites, 28.577 units of sale data were downloaded from only one real estate site. The methods used for the analysis of the collected data were coded in the R language and analyzed.  A dashboard created with R ShinyAPP has been prepared.

Using Shiny App

District filter : For choosing district of Istanbul. After run ShinyApp you see first district selected "Bakirkoy". This filter is multichoice filter. You can add district.

Bulding Age Filter: This filter shows building age. After run ShinyApp you see first building age selected "0_5".  This filter is multichoice filter. You can add building age.

Number of Rooms: This filter shows house's rooms count. After run ShinyApp you see first room selected "5".  This filter is multichoice filter. You can add Number of Rooms.

Price slider: This slider includin min house and max house price. You can choose house price related your budget.

Radio Group Button : It has two different select button . Price and Unit Square Meter Price. This button is intractive and changes graphics.

In the Istanbul Real Estate Valuation app , I used two different graphics. First one is scatter plot . It shows relation with Gross square metre and Price ,Gross square metre and square_meter_price. Graphics are colored by district in addition to giving heating system features different shape.

Second graphic is a box plot and shows house price and square_meter_price for each district. The graphic shows us deviant value each district.When you come on box plot, It shows Quartiles value.

Between the two graphs, renderPrint shows the region and the average Price for that region.

runApp('~/R_shiny_app_midterm_967585')

runGitHub("R_shiny_app_midterm","fatmaaerr",ref = "main")

