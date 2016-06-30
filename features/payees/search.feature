@baseUrl @baseUrl-farotest
Feature: Search Payees
    Search for all payees on an account

Scenario: Search for payees on an HSA account
    Given the synthetic id "4|270000000|null|OPT|HSA|null"
    When I make a POST request to "/payees/v1.0/search"
    Then the response status code should be "200"
    
Scenario: Searching for payees without synthetic id should throw error
    Given the json request data
    """
    {}
    """
    When I make a POST request to "/payees/v1.0/search"
    Then the response status code should be "400"
    
Scenario: Should not be able to search using a GET request
    Given the synthetic id "4|270000000|null|OPT|HSA|null"
    When I make a GET request to "/payees/v1.0/search"
    Then the response status code should be "405"
    
Scenario: Search should fail with an invalid account number
    Given the synthetic id "4|123|null|OPT|HSA|null"
    When I make a POST request to "/payees/v1.0/search"
    Then the response status code should be "502"
    And the response property "status.messages[0].code" should be "404"