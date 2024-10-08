Feature: Search News Article by Representative and Issue

  Scenario: User selects a representative and issue, then clicks search
    Given I am at the actionmap home page
    And I click on the "Login" link
    And I press "Sign in with GitHub"
    Then I should be at the actionmap home page
    And I click on the "Representative" link
    And I type in 'California'
    And I should see "Joseph R. Biden"
    When I press "News Articles" button of "Joseph R. Biden"
    When I press on "Add News Article"
    Then I should see Select Representative and Issue
    Then I select a representative and issue
    And I click on the search button
    Then I am at the new_page2
