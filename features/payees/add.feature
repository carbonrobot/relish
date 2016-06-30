@baseUrl @baseUrl-farotest
Feature: Add new payees
    Adds a new payee to an existing account
    
Scenario: Add a new payee
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
    
Scenario: Don't allow creating a payee with a duplicate nickName
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
    When I make a POST request to "/payees/v1.0"
    Then the response status code should be "502"
    And the response property "status.messages[0].code" should be "400"
    
Scenario Outline: Payee field validations
    Given the synthetic id "4|270000000|null|OPT|HSA|null"
    And the property "payeeName" is set to "<payeeName>"
    And the property "payeeAccountNumber" is set to "<acctNumber>"
    And the property "address1" is set to "<address1>"
    And the property "address2" is set to "<address2>"
    And the property "city" is set to "<city>"
    And the property "state" is set to "<state>"
    And the property "zip" is set to "<zip>"
    And the property "nickName" is a random word
    When I make a POST request to "/payees/v1.0"
    Then the response status code should be "<responseCode>"
    
    Examples:
    | payeeName | acctNumber   | address1       | address2 | city       | state | zip        | responseCode |
    
    # validate address2 is optional
    | Seaton    | V00062567748 | P.O. Box 15618 |          | Wilmington | DE    | 19850-5618 | 200          |
    
    # check required fields
    |           | V00062567748 | P.O. Box 15618 |          | Wilmington | DE    | 19850-5618 | 400          |
    | Seaton    |              | P.O. Box 15618 |          | Wilmington | DE    | 19850-5618 | 400          |
    | Seaton    | V00062567748 |                |          | Wilmington | DE    | 19850-5618 | 400          |
    | Seaton    | V00062567748 | P.O. Box 15618 |          |            | DE    | 19850-5618 | 400          |
    | Seaton    | V00062567748 | P.O. Box 15618 |          | Wilmington |       | 19850-5618 | 400          |
    | Seaton    | V00062567748 | P.O. Box 15618 |          | Wilmington | DE    |            | 400          |
    
    # payee name field max length 35
    | aaaaaaaaaabjdsjdjdjsksioekdlkhgrews   | V00062567748 | P.O. Box 15618 |  | Wilmington | DE | 19850-5618 | 200 |
    | aaaaaaaaaabjdsjdjdjsksioekdlkhgrewsd  | V00062567748 | P.O. Box 15618 |  | Wilmington | DE | 19850-5618 | 400 |
    
    # payeeAccountNumber field max length 30
    | Seaton    | jhgfdertyuioliuytresderftghytr  | P.O. Box 15618 |          | Wilmington | DE | 19850-5618 | 200 |
    | Seaton    | jhgfdertyuioliuytresderftghytrf | P.O. Box 15618 |          | Wilmington | DE | 19850-5618 | 400 |
    
    # address1 field max length 30
    | Seaton    | V00062567748 | jhgfdertyuioliuytresderftghytr  |          | Wilmington | DE | 19850-5618 | 200 |
    | Seaton    | V00062567748 | jhgfdertyuioliuytresderftghytrf |          | Wilmington | DE | 19850-5618 | 400 |
    
    # address2 field max length 30
    | Seaton    | V00062567748 | P.O. Box 15618 | jhgfdertyuioliuytresderftghytr  | Wilmington | DE | 19850-5618 | 200 |
    | Seaton    | V00062567748 | P.O. Box 15618 | jhgfdertyuioliuytresderftghytrf | Wilmington | DE | 19850-5618 | 400 |
    
    # city field max length 24
    | Seaton    | V00062567748 | P.O. Box 15618 |  | WilmingtonDelawareApplet  | DE | 19850-5618 | 200 |
    | Seaton    | V00062567748 | P.O. Box 15618 |  | WilmingtonDelawareAppleto | DE | 19850-5618 | 400 |
    
    # state field max length 2
    | Seaton    | V00062567748 | P.O. Box 15618 |          | Wilmington | DEZ | 19850-5618 | 400 |
    
    # state field should not allow numbers
    | Seaton    | V00062567748 | P.O. Box 15618 |          | Wilmington | 99 | 19850-5618 | 400 |
    
    # zip code max length 9
    | Seaton    | V00062567748 | P.O. Box 15618 |          | Wilmington | DE | 19850-56185 | 400 |
    
    # zip code should not allow letters
    | Seaton    | V00062567748 | P.O. Box 15618 |          | Wilmington | DE | abcdef | 400 |
    