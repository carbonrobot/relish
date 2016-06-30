@baseUrl @baseUrl-farotest
Feature: Update Payees
    Updates an existing payee
        
Scenario: Update an existing payee
    # First, create a new payee
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
    And the response property "result.data.city" should be "Wilmington"
    
    # Try to update the payee we just created
    Given the synthetic id from the response
    And the json request data 
    """json
    {
        "payeeName": "Seaton Health System",
        "payeeAccountNumber": "V00062567748",
        "address1": "P.O. Box 15618",
        "address2": "",
        "city": "Appleton",
        "state": "DE",
        "zip": "19850-5618",
        "nickName": "Health System"
    }
    """
    And the property "nickName" is set to the response property "result.data.payeeNickname"
    When I make a POST request to "/payees/v1.0"
    Then the response status code should be "200"
    And the response property "result.data.city" should be "Appleton"
          
Scenario: Don't allow updating a payee nickname to a duplicate
    # First, create a new payee
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
        "nickName": ""
    }
    """
    And the property "nickName" is a random word
    When I make a POST request to "/payees/v1.0"
    Then the response status code should be "200"
    And the response property "result.data.city" should be "Wilmington"
    
    # Try to update the payee with a duplicate nickname
    Given the synthetic id from the response
    And the json request data 
    """json
    {
        "payeeName": "Seaton Health System",
        "payeeAccountNumber": "V00062567748",
        "address1": "P.O. Box 15618",
        "address2": "",
        "city": "Appleton",
        "state": "DE",
        "zip": "19850-5618",
        "nickName": "Health System"
    }
    """
    When I make a POST request to "/payees/v1.0"
    Then the response status code should be "502"
    And the response property "status.messages[0].code" should be "400"