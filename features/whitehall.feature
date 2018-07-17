Feature: Whitehall
  This is the Whitehall application that powers most pages under
  www.gov.uk/government and the detailed guidance format type.

  @normal
  Scenario: Government publishing section on GOV.UK homepage
    Given I am testing through the full stack
    And I force a varnish cache miss
    Then I should see the departments and policies section on the homepage

  @normal @notintegration
  Scenario: There should be no authentication for Whitehall
    Given I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to view policies
    And I should be able to view announcements
    And I should be able to view publications
    Then I should be able to visit:
      | Path                      |
      | /government/topics        |
      | /government/consultations |
      | /government/ministers     |
      | /government/world         |

  @normal
  Scenario: Searching for an existing consultation on whitehall via elastic search
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I do a whitehall search for "Assessing radioactive waste disposal sites"
    Then I should see "Assessing radioactive waste disposal sites"

  @normal
  Scenario: Feeds should be available for documents
    Given I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path                           |
      | /government/announcements.atom |
      | /government/publications.atom  |

  @normal
  Scenario: Visiting whitehall
    Given I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to view policies
    And I should be able to view announcements
    And I should be able to view publications
    Then I should be able to visit:
      | Path                             |
      | /government/how-government-works |
      | /government/get-involved         |
      | /government/topics               |
      | /government/consultations        |
      | /government/ministers            |
      | /government/world                |

  @normal
  Scenario: Whitehall assets are redirected to and served from the asset host
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I request an attachment
    Then I should be redirected to the asset host
    And the attachment should be served successfully

  @normal
  Scenario: Formats rendered by Whitehall respond OK
    Given I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path                                     |
      | /government/how-government-works         |
      | /government/people/eric-pickles          |
    And I should get a 200 status code
