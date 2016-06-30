@baseUrl @baseUrl-farotest
Feature: Add Contributions
    The support of adding and updating of a contribution/deposit to a consumer account. The frequency can be one-time or on a recurring schedule.

Scenario: Add a one-time contribution to a checking account 3 days in the future
    Given the synthetic id "4|904052381|qwr|OPT|HSA|null"
    And The json request data
    """json
    {
        "transactionDate": "06-25-2016",
        "fromAccountId": "99745",
        "fromAccountType":"Checking",
        "contributionYear": "Current Year",
        "frequency": "One time",
        "amount": "300.0"
    }
    """
    And the property "transactionDate" is a date "3" days in the future
    When I make a POST request to "/contributions/v1.0"
    Then the response status code should be "200"
    
Scenario: Add a one-time contribution to a checking account for todays date
    Given the synthetic id "4|904052381|qwr|OPT|HSA|null"
    And The json request data
    """json
    {
        "transactionDate": "06-25-2016",
        "fromAccountId": "99745",
        "fromAccountType":"Checking",
        "contributionYear": "Current Year",
        "frequency": "One time",
        "amount": "300.0"
    }
    """
    And the property "transactionDate" is todays date
    When I make a POST request to "/contributions/v1.0"
    Then the response status code should be "200"
    
Scenario: Should not be able to make a contribution for a past date
    Given the synthetic id "4|904052381|qwr|OPT|HSA|null"
    And The json request data
    """json
    {
        "transactionDate": "06-25-2016",
        "fromAccountId": "99745",
        "fromAccountType":"Checking",
        "contributionYear": "Current Year",
        "frequency": "One time",
        "amount": "300.0"
    }
    """
    And the property "transactionDate" is a date "3" days in the past
    When I make a POST request to "/contributions/v1.0"
    Then the response status code should be "400"
    
Scenario: Should not be able to make a contribution without a synthetic id
    And The json request data
    """json
    {
        "transactionDate": "06-25-2016",
        "fromAccountId": "99745",
        "fromAccountType":"Checking",
        "contributionYear": "Current Year",
        "frequency": "One time",
        "amount": "300.0"
    }
    """
    And the property "transactionDate" is todays date
    When I make a POST request to "/contributions/v1.0"
    Then the response status code should be "400"