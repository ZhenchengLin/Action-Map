Feature: add issue attribute for news items

  As a user of ActionMap
  So that I can group together News Articles by Issue topic
  I want to add an Issues column to each News Article

  Scenario: view the issue attribute in news info page
    Given I have some data in my database
    Given I am at the actionmap home page
    And I click on the "Representative" link
    And I type in 'California'
    And I should see "Gavin Newsom"
    When I press "News Articles" button of "Gavin Newsom"
    When I press on "Info"
    Then I should see "Issue"
  
  Scenario: set the issue attribute in news create page
    Given I am at the actionmap home page
    And I click on the "Login" link
    And I press "Sign in with GitHub"
    Then I should be at the actionmap home page
    And I click on the "Representative" link
    And I type in 'California'
    And I should see "Joseph R. Biden"
    When I press "News Articles" button of "Joseph R. Biden"
    When I press on "Add News Article"
    Then I should see "Issue"
  
  Scenario: set the issue attribute in news edit page
    Given I have some data in my database
    Given I am at the actionmap home page
    And I click on the "Login" link
    And I press "Sign in with GitHub"
    Then I should be at the actionmap home page
    And I click on the "Representative" link
    And I type in 'California'
    And I should see "Gavin Newsom"
    When I press "News Articles" button of "Gavin Newsom"
    When I press on "Edit"
    Then I should see "Issue"
