@baseUrl @baseUrl-examples
Feature: REST API Examples
    The following examples show the features of this testing application
    and available options for data

Scenario: Making a simple GET request
    When I make a GET request to "/posts/1"
    Then The response property "userId" should be "1"
    And The response property "id" should be "1"

Scenario: Making a POST request with json data
    Given The json request data
    """json
    {
        "title": "foo",
        "body": "bar",
        "userId": 1
    }
    """
    When I make a POST request to "/posts"
    Then The response property "userId" should be "1"
    And The response property "id" should be "101"

Scenario: Making a POST request using tabular data (same as above, but alternate format)
    Given The request data
    | title | body | userId |
    | foo   | bar  | 1      |
    When I make a POST request to "/posts"
    Then The response property "userId" should be "1"
    And The response property "id" should be "101"

Scenario: Making a simple DELETE request
    When I make a DELETE request to "/posts/1"
    Then The response status code should be "200"

Scenario: Automatically generating the synthetic ID for POST request
    Given The synthetic id "12345|EV1|98415|51681"
    And The json request data
    """json
    {
        "title": "foo",
        "body": "bar",
        "userId": 1
    }
    """
    When I make a POST request to "/posts"
    Then The response status code should be "201"

Scenario: Automatically generating the synthetic ID for GET or DELETE request
    Given The synthetic id "12345|EV1|98415|51681"
    When I make a GET request to "/posts/{syntheticId}"
    Then The response status code should be "404" 

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