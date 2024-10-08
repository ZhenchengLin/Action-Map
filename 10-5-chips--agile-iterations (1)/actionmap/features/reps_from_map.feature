Feature: display representatives when clicking on a county map

  As a user of ActionMap
  So that I can see the representatives of that county
  I want to make clicking on a county in the map functional

Scenario: find representatives in Alameda County, CA
  Given I am on the ActionMap home page
  # When I click on the state "CA"
  # Then I am visiting the "California" state page
  And I am not visiting the "Washington" state page
  When I click the county titled "Alameda County, CA"
  Then I am viewing the "Alameda County" representatives page
  And I am not viewing the "Mono County" representatives page
  And I should see the following representatives: Joseph R. Biden,Kamala D. Harris,Alex Padilla,Laphonza R. Butler,Gavin Newsom,Eleni Kounalakis,Tony Thurmond,Ricardo Lara,Rob Bonta,Malia M. Cohen,Shirley N. Weber,Fiona Ma,Carol A. Corrigan,Goodwin H. Liu,Joshua P. Groban,Kelli Evans,Leondra R. Kruger,Martin J. Jenkins,Patricia Guerrero,Alysse Castro,Henry C. Levy,Pamela Price,Yesenia Sanchez,Melissa Wilk,Phong La

Scenario: counties with the same name are correctly displayed (Two Smith Counties; One in TX, One in TN)
  Given I am on the ActionMap home page
  # When I click on the state "TX"
  # Then I am visiting the "Texas" state page
  And I am not visiting the "Oklahoma" state page
  When I click the county titled "Smith County, TX"
  Then I am viewing the "Smith County" representatives page
  And I should see the following representatives: Joseph R. Biden,Kamala D. Harris,Ted Cruz,Nathaniel Moran,Greg Abbott,Dan Patrick,Glenn Hegar,Christi Craddick,Jim Wright,Wayne Christian,Ken Paxton,Dawn Buckingham,Sid Miller,Barbara Hervey,Bert Richardson,David Newell,Jesse F. McClure III,Kevin Yeary,Mary Lou Keel,Michelle Slaughter,Scott Walker,Sharon Keller,Brett Busby,Debra Lehrmann,Evan A. Young,Jane Bland,Jeff Boyd,Jimmy Blacklock,John Phillip Devine,Rebeca Aizpuru Huddle,Nathan L. Hecht,Neal Franklin,Penny Clarkston,Jacob Putman,Kelli R. White,Karen Phillips,Gary Barber,Larry R. Smith
  And I should not see the following representatives: Bill Hagerty,Marsha Blackburn,John W. Rose,Bill Lee,Dwight E. Tarwater,Holly Kirby,Jeffrey S. Bivins,Roger A. Page,Sarah K. Campbell,Jeff Mason,Jerri Lin Vaden-Malone,Mickey Barrett,Clifa Norris,Terry Collins,Steve Hopper,Julie Wright,Tommy Turner

Scenario: representatives are displayed in the correct order
  Given I am on the ActionMap home page
  # When I click on the state "CA"
  # Then I am visiting the "Florida" state page
  And I am not visiting the "Georgia" state page
  When I click the county titled "Palm Beach County, FL"
  Then I am viewing the "Palm Beach County" representatives page
  And I should see representative "Rick Scott" before "Ric Bradshaw"
  And I should see representative "Ron DeSantis" before "Dorothy Jacks"

Scenario: Representatives in Los Angeles County, CA
  Given I am on the ActionMap home page
  When I click on the state "CA"
  And I am not visiting the "Nevada" state page
  When I click the county titled "Los Angeles County, CA"
  Then I am viewing the "Los Angeles County" representatives page
  And I should see the following representatives: Joseph R. Biden,Kamala D. Harris,Alex Padilla,Laphonza R. Butler,Gavin Newsom,Eleni Kounalakis,Tony Thurmond,Ricardo Lara,Rob Bonta,Malia M. Cohen,Shirley N. Weber,Fiona Ma,Carol A. Corrigan,Goodwin H. Liu,Joshua P. Groban,Kelli Evans,Leondra R. Kruger,Martin J. Jenkins,Patricia Guerrero

Scenario: Check multiple counties for representatives
  Given I am on the ActionMap home page
  When I click on the state "FL"
  And I am not visiting the "Georgia" state page
  When I click the county titled "Miami-Dade County, FL"
  Then I am viewing the "Miami-Dade County" representatives page
  And I should see the following representatives: Joseph R. Biden,Kamala D. Harris,Marco Rubio,Rick Scott
  When I press the "profile" button for "Joseph R. Biden"
  Then I should see "Title: President of the United States"
  And I should see "OCD ID: ocd-division/country:us"
  And I should see "Political Party: Democratic Party"
  And I should see "Contact Address: 1600 Pennsylvania Avenue Northwest, Washington, DC 20500"

