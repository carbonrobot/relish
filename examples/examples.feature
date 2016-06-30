@baseUrl @baseUrl-examples
Feature: REST API Examples
    The following examples show the features of this testing application
    and available options for data

Scenario: Making a simple GET request
    When I make a GET request to "/posts/1"
    Then The response property "userId" should be "1"
    And The response property "id" should be "1"

Scenario: Making a simple DELETE request
    When I make a DELETE request to "/posts/1"
    Then The response status code should be "200"

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

Scenario: Making a POST request using phrases (same as above, but alternate format)
    Given the property "title" is set to "foo"
    And the property "body" is set to "bar"
    And the property "userId" is set to "1"
    When I make a POST request to "/posts"
    Then The response property "userId" should be "1"
    And The response property "id" should be "101"

Scenario Outline: Using examples to run multiple tests
    Given the property "title" is set to "<title>"
    And the property "body" is set to "<body>"
    And the property "userId" is set to "<userid>"
    When I make a POST request to "/posts"
    Then The response property "userId" should be "<userid>"

    Examples:
    | title | body | userId |
    | foo   | bar  | 1      |
    | fooz  | barz | 1      |




