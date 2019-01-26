Feature: Get Car2go updates
  Scenario: A parked vehicle changes its state to moving
    Given A "parked" vehicle with vin "1234"
    And a list of "parked" vehicles
    When vehicle with vin "1234" is NOT in vehicles list
    And update vehicle with vin "1234" to moving
    Then vehicle with vin "1234" has "moving" state

  Scenario: A parked vehicle changes its state to moving
    Given A "parked" vehicle with vin "1234"
    And a list of "parked" vehicles
    When vehicle with vin "1234" is in vehicles list
    And update vehicle with vin "1234" to moving
    Then vehicle with vin "1234" has NOT "moving" state
