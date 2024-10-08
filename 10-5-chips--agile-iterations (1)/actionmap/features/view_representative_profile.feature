Feature: View Representative Profile

  Scenario: View two Representative Profile with all details in SF
    Given I am at the actionmap home page
    When I click on the "Representative" link
    And I type in 'San Francisco'
    Then I should see "Joseph R. Biden" before "Kamala D. Harris"
    And I should see "President of the United States" before "Vice President of the United States"
    And I should see "Kamala D. Harris"
    And I should see "Alex Padilla"
    And I should see "Laphonza R."
    And I should see "Gavin Newsom"
    And I should see "Eleni Kounalakis"
    When I press the "profile" button for "Joseph R. Biden"
    Then I should see "Title: President of the United States"
    And I should see "OCD ID: ocd-division/country:us"
    And I should see "Political Party: Democratic Party"
    And I should see "Contact Address: 1600 Pennsylvania Avenue Northwest, Washington, DC 20500"
    When I click on the "Back" link
    And I type in 'San Francisco'
    When I press the "profile" button for "Kamala D. Harris"
    Then I should see "Kamala D. Harris"
    And I should see "Title: Vice President of the United States"
    And I should see "OCD ID: ocd-division/country:us"
    And I should see "Political Party: Democratic Party"


	Scenario: View all representatives in San Francisco
    Given I am at the actionmap home page
    When I click on the "Representative" link
    And I type in 'San Francisco'
    And I should see 'Joseph R. Biden'
    And I should see 'Kamala D. Harris'
    And I should see 'Alex Padilla'
    And I should see 'Laphonza R. Butler'
    And I should see 'Gavin Newsom'
    And I should see 'Eleni Kounalakis'
    And I should see 'Tony Thurmond'
    And I should see 'Ricardo Lara'
    And I should see 'Rob Bonta'
    And I should see 'Malia M. Cohen'
    And I should see 'Shirley N. Weber'
    And I should see 'Fiona Ma'
    And I should see 'Carol A. Corrigan'
    And I should see 'Goodwin H. Liu'
    And I should see 'Joshua P. Groban'
    And I should see 'Kelli Evans'
    And I should see 'Leondra R. Kruger'
    And I should see 'Martin J. Jenkins'
    And I should see 'Patricia Guerrero'
    And I should see 'London Breed'
    And I should see 'Joaquín Torres'
    And I should see 'Brooke Jenkins'
    And I should see 'Paul M. Miyamoto'
    And I should see 'Manohar Raju'
    And I should see 'José Cisneros'
    And I should see 'David Chiu'

		Scenario: View two Representative Profile with all details in San Diego
		Given I am at the actionmap home page
    When I click on the "Representative" link
    And I type in 'San Diego'
		When I press the "profile" button for "Joseph R. Biden"
    Then I should see "Title: President of the United States"
    And I should see "OCD ID: ocd-division/country:us"
    And I should see "Political Party: Democratic Party"
    And I should see "Contact Address: 1600 Pennsylvania Avenue Northwest, Washington, DC 20500"
    When I click on the "Back" link
    And I type in 'San Francisco'
    When I press the "profile" button for "Kamala D. Harris"
    Then I should see "Kamala D. Harris"
    And I should see "Title: Vice President of the United States"
    And I should see "OCD ID: ocd-division/country:us"
    And I should see "Political Party: Democratic Party"


		Scenario: View two Representative Profile with all details in New York
		Given I am at the actionmap home page
    When I click on the "Representative" link
    And I type in 'New York'
		When I press the "profile" button for "Joseph R. Biden"
    Then I should see "Title: President of the United States"
    And I should see "OCD ID: ocd-division/country:us"
    And I should see "Political Party: Democratic Party"
    And I should see "Contact Address: 1600 Pennsylvania Avenue Northwest, Washington, DC 20500"
    When I click on the "Back" link
    And I type in 'San Francisco'
    When I press the "profile" button for "Kamala D. Harris"
    Then I should see "Kamala D. Harris"
    And I should see "Title: Vice President of the United States"
    And I should see "OCD ID: ocd-division/country:us"
    And I should see "Political Party: Democratic Party"

		Scenario: View two Representative Profile with all details in Texas
		Given I am at the actionmap home page
    When I click on the "Representative" link
    And I type in 'Texas'
		When I press the "profile" button for "Joseph R. Biden"
    Then I should see "Title: President of the United States"
    And I should see "OCD ID: ocd-division/country:us"
    And I should see "Political Party: Democratic Party"
    And I should see "Contact Address: 1600 Pennsylvania Avenue Northwest, Washington, DC 20500"
    When I click on the "Back" link
    And I type in 'San Francisco'
    When I press the "profile" button for "Kamala D. Harris"
    Then I should see "Kamala D. Harris"
    And I should see "Title: Vice President of the United States"
    And I should see "OCD ID: ocd-division/country:us"
    And I should see "Political Party: Democratic Party"


		