@baseUrl @baseUrl-farotest
Feature: Single Payee
    Retrieve a single payee for an account

Scenario: Get a single payee
    Given the synthetic id "4|904052381|qwr|OPT|HSA|732705"
    When I make a GET request to "/payees/v1.0/{syntheticId}"
    Then the response status code should be "200"
    
Scenario: Get a single payee without syntheticId should return error
    When I make a GET request to "/payees/v1.0/12"
    Then the response status code should be "400"
    
Scenario: Get a single payee with incorrect HTTP method returns error
    Given the synthetic id "4|904052381|qwr|OPT|HSA|732705"
    When I make a POST request to "/payees/v1.0/{syntheticId}"
    Then the response status code should be "405"
    
Scenario: Get a single payee with invalid account number
    Given the synthetic id "4|9052381|qwr|OPT|HSA|732705"
    When I make a GET request to "/payees/v1.0/{syntheticId}"
    Then the response status code should be "502"
    And the response property "status.messages[0].code" should be "404"
