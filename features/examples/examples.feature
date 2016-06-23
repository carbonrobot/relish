Feature: REST API Examples
    The following examples show the features of this testing application
    and available options for data

Scenario: Making a simple GET request
    When I make a GET request to "http://jsonplaceholder.typicode.com/posts/1"
    Then The response property "userId" should have value "1"
    And The response property "id" should have value "1"

Scenario: Making a POST request with json data
    Given The json request data
    """json
    {
        "title": "foo",
        "body": "bar",
        "userId": 1
    }
    """
    When I make a POST request to "http://jsonplaceholder.typicode.com/posts"
    Then The response property "userId" should have value "1"
    And The response property "id" should have value "101"

Scenario: Making a POST request using tabular data (same as above, but alternate format)
    Given The request data
    | title | body | userId |
    | foo   | bar  | 1      |
    When I make a POST request to "http://jsonplaceholder.typicode.com/posts"
    Then The response property "userId" should have value "1"
    And The response property "id" should have value "101"

Scenario: Making a simple DELETE request
    When I make a DELETE request to "http://jsonplaceholder.typicode.com/posts/1"
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
    When I make a POST request to "http://jsonplaceholder.typicode.com/posts"
    Then The response status code should be "201"

Scenario: Automatically generating the synthetic ID for GET or DELETE request
    Given The synthetic id "12345|EV1|98415|51681"
    When I make a GET request to "http://jsonplaceholder.typicode.com/posts/{syntheticId}"
    Then The response status code should be "404" 