@baseUrl @baseUrl-farotest
Feature: Delete Payee
    Delete a single payee from an account

Scenario: Delete a single payee
    # First, create the payee, so we can try to delete it
    Given the synthetic id "4|270000000|null|OPT|HSA|null"
    And the json request data
    """json
    {
        "payeeName": "Seaton Health System",
        "payeeAccountNumber": "V00062567748",
        "address1": "P.O. Box 15618",
        "address2": "",
        "city": "Wilmington",
        "state": "DE",
        "zip": "19850-5618",
        "nickName": "Health System"
    }
    """
    And the property "nickName" is a random word
    When I make a POST request to "/payees/v1.0"
    Then the response status code should be "200"
    
    # try to delete the payee we just created
    Given the synthetic id from the response
    When I make a DELETE request to "/payees/v1.0/{syntheticId}"
    Then the response status code should be "200"
    
Scenario: Delete a payee without synthetic id should fail
    When I make a DELETE request to "/payees/v1.0/1234"
    Then the response status code should be "400"
    
Scenario: Delete a payee without an invalid synthetic id should fail
    Given the synthetic id "4|270000000|null|OPT|HSA|null"
    When I make a DELETE request to "/payees/v1.0/{syntheticId}"
    Then the response status code should be "400"