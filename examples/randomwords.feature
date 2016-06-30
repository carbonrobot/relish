@baseUrl @baseUrl-examples
Feature: Generating random data
    The following examples show the features of this testing application
    and available options for generating random data

Scenario: Generating a random word for test data
    Given The json request data
    """json
    {
        "title": "foo",
        "body": "bar",
        "userId": 1
    }
    """
    And the property "title" is a random word
    When I make a POST request to "/posts"
    Then the response status code should be "201"

Scenario: Generating random words for test data (space delimited)
    Given The json request data
    """json
    {
        "title": "foo",
        "body": "bar",
        "userId": 1
    }
    """
    And the property "title" is "4" random words
    When I make a POST request to "/posts"
    Then the response status code should be "201"