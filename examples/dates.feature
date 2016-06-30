@baseUrl @baseUrl-examples
Feature: Handling Dates
    The following examples show the features of this testing application
    and available options for handling dates

Scenario: Making a request with a timestamp of todays date
    Given The json request data
    """json
    {
        "title": "foo",
        "body": "bar",
        "userId": 1,
        "ts": ""
    }
    """
    And The property "ts" is todays date
    When I make a POST request to "/posts"
    Then the response status code should be "201"

Scenario: Making a request with a timestamp in the future
    Given The json request data
    """json
    {
        "title": "foo",
        "body": "bar",
        "userId": 1,
        "ts": ""
    }
    """
    And The property "ts" is a date "3" days in the future
    When I make a POST request to "/posts"
    Then the response status code should be "201"

Scenario: Making a request with a timestamp in the past
    Given The json request data
    """json
    {
        "title": "foo",
        "body": "bar",
        "userId": 1,
        "ts": ""
    }
    """
    And The property "ts" is a date "3" days in the past
    When I make a POST request to "/posts"
    Then the response status code should be "201"

Scenario: Changing the default date format (MM-DD-YYYY)
    # The date format is controlled by moment.js 
    Given The json request data
    """json
    {
        "title": "foo",
        "body": "bar",
        "userId": 1,
        "ts": ""
    }
    """
    And The property "ts" is todays date with format "YYYY-MM-DD"
    When I make a POST request to "/posts"
    Then the response status code should be "201"