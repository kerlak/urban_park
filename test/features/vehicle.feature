Feature: Vehicle updates
  Scenario: A vehicle has state :parked when it get that information
    Given A vehicle with "unknown" state and "1234" vin
    When updated with "parked" state and "1234" vin
    Then has "parked" state

  Scenario: A vehicle still has his state when it get that information from other vehicle
    Given A vehicle with "unknown" state and "1234" vin
    When updated with "parked" state and "5678" vin
    Then has "unknown" state

  Scenario: A vehicle update its last_parked_ping to now when receive another :parked update
    Given A vehicle with "parked" state and "1234" vin
    When updated with "parked" state and "1234" vin
    Then has update the ping

  Scenario: A vehicle do not update its last_parked_ping when receive another update
    Given A vehicle with "unknown" state and "1234" vin
    When updated with "unknown" state and "1234" vin
    Then has not update the ping

  Scenario: A vehicle update its last_parked_ping when receive the first :parked update
    Given A vehicle with "unknown" state and "1234" vin
    When updated with "parked" state and "1234" vin
    Then has update the ping

  Scenario: A vehicle still has his state when it get that information from other vehicle
    Given A vehicle with lat 44 lon 33 coordinates and "1234" vin
    When updated with lat 45 lon 34 coordinates and "1234" vin
    Then has lat 45 lon 34 coordinates
