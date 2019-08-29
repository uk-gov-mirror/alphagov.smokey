Feature: Brexit questionnaire

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  @high
  Scenario: Check the Brexit questionnaire works for EU nationals in UK
    Given I am an EU national
    And I work in the UK
    When I start the brexit questionaire
    Then I should be asked if I own a business
    Then I should be asked about my nationality
    Then I should be asked if I plan to join an EU family member in the UK
    Then I should be asked where I live
    Then I should be asked what I do
    Then I should be asked if I want to travel to the UK after Brexit
    Then I should see the results page
    And I should see confirmation of my answers
    And I should see answers tailored to me

  @high
  Scenario: Check the Brexit questionnaire works for farmers
    Given I am a farmer
    And I am a UK national
    And I live in the UK
    And I sell goods in the UK
    And I import goods from the EU
    And I do business in the EU
    And I export goods to the EU
    And I transport goods across border
    When I visit "/get-ready-brexit-check/questions"
    Then I should be asked if I own a business
    Then I should be asked what my business does
    Then I should be asked about my business activities
    Then I should be asked if I employ people from other European countries
    Then I should be asked if I share data across EU borders
    Then I should be asked if I rely on IP protection
    Then I should be asked about government funding
    Then I should be asked if I service the public sector
    Then I should be asked about my nationality
    Then I should be asked where I live
    Then I should be asked if I plan to travel to the EU
    Then I should be asked if I have property in the EU
    Then I should see the results page
    And I should see confirmation of my answers
    And I should see answers tailored to me

  @high
  Scenario: Check the Brexit questionnaire works for EU national business owners
    Given I am a business owner
    And I am an EU national
    And I import goods from the EU
    When I visit "/get-ready-brexit-check/questions"
    Then I should be asked if I own a business
    Then I should be asked what my business does
    Then I should be asked about my business activities
    Then I should be asked if I am an EU national
    Then I should see the results page
    And I should see confirmation of my answers
    And I should see answers tailored to me

  @high
  Scenario: Check the Brexit questionnaire works for unaffected people
    When I visit "/get-ready-brexit-check/questions"
    Then I should be asked if I own a business
    Then I should be asked if I am an EU national
    Then I should see the results page
    And I should see confirmation of my answers
    And I should see answers tailored to me

  @high
  Scenario: Check that the Brexit questionnaire can be subscribed to
    Given I am an EU national
    When I visit "/get-ready-brexit-check/questions"
    Then I should be asked if I own a business
    Then I should be asked if I am an EU national
    Then I should see the results page
    Then I should see confirmation of my answers
    And I should see answers tailored to me
    When I click Subscribe link
    Then I should be on the page "/get-ready-brexit-check/email-signup?c%5B%5D=eu-national"
    When I click Subscribe button
    Then I should be on the page "/email/subscriptions/new?topic_id=brexit-checklist-eu-national"
