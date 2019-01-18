Feature: Parking spots
  Scenario: Get a list of released spots
    Given Nothing implemented yet
    When request for realeased spots
    Then return an empty list

  Scenario: Add new vehicles to the list of vehicles
    Given A list of vehicles
    When request for vehicles updates
    Then the list of vehicles have the new ones

  Scenario: Update vehicles information
    Given A list of vehicles
    When request for vehicles updates
    Then the existing vehicles update its information
