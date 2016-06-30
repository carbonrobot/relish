FARO ATDD Testing Suite
---------------

REST API Testing with javascript and cucumber

## Getting Started

The following software must be installed for development.

- Install GIT from the Appstore or online.
- Install the newest version of Nodejs you have access to from Appstore or online.

After Nodejs is installed, open your GIT BASH window and clone this repository into your projects folder.

```bash
$ git clone https://codehub.optum.com/optum-financial-portals/faro-test
$ cd faro-test
```

Then, run the following command to install dependencies

```bash
$ npm install
```

##  Running the Tests

To run all tests, run the following command from the project directory.

```bash
$ npm test
```

To run a single feature file, run the following command from the project directory.

```bash
$ npm test features/myfeature.feature
```

To run a single test in a feature file, run the following command from the project directory. 
In this example "23" is the line number of the test in the file.

```bash
$ npm test features/myfeature.feature:23
```

Running the Examples

```bash
$ npm test examples
```

## Writing Tests

You can use any text editor you would like to use. I recommend using VSCode or UltraEdit.

Place new feature files in the `features` folder. Features can and should be organized into folders.

Refer to the `examples` folder for full examples of what is possible with this framework.

**Example**

```
@baseUrl @baseUrl-farotest
Feature: Add Contributions
    The support of adding and updating of a contribution/deposit to a consumer account. The frequency can be one-time or on a recurring schedule.

Scenario: Add a one-time contribution to a checking account
    Given the synthetic id "2|99999|168504|OPT|HSA|123459999999999"
    And The json request data
    """json
    {
        "amount": "133.0",
        "TransactionDate": "01-09-2016", 
        "FromAccountID": "22923",
        "FromAccountType": "Checking",
        "contributionYear": "Current Year",
        "frequency": "one time"
    }
    """
    And the property "TransactionDate" is a date "3" days in the future
    When I make a POST request to "/contributions/v1.0"
    Then the response status code should be "200"
```

## Available Syntax

The following assertions are available in feature files.

### Setting up data

**To include a synthetic id in the request**, use the following phrase and insert the correct data that composes the synthetic id between the quotation marks. See the examples for how to use this combined with other assertions.

```
Given the synthetic id "12345|CAP|123489|514681"
```

**To include data in the request**, use the following phrase and a special block containing the data. Do not include synthetic id in this section, instead use the section above.

```
Given The json request data
"""json
{
    "title": "foo",
    "body": "bar",
    "userId": 1
}
"""
```

An alternative format to the above. This is equivalent to the above, just a different format. This gets turned into JSON in the request, so it makes no difference which one you use, its just preference.

```
Given The request data
| title | body | userId |
| foo   | bar  | 1      |
```

### Making requests

**To make a GET request**, use the following phrase, supplying the url in between quotation marks.

```
When I make a GET request to "http://jsonplaceholder.typicode.com/posts/1"
```

**To make a DELETE request**, use the following phrase, supplying the url in between quotation marks.

```
When I make a DELETE request to "http://jsonplaceholder.typicode.com/posts/1"
```

**To make a POST request**, combine the data patterns above with the following action statement.

```
Given The request data
| title | body | userId |
| foo   | bar  | 1      |
When I make a POST request to "http://jsonplaceholder.typicode.com/posts"
```

### Verify results

**To verify the status code of a response**, use the following

```
Then the response status code should be "404"
```

**To verify a simple response** containing a single word or value, use the following

```
Then the response should match "Completed"
``` 

**To check a value in a JSON response**, specify the path to the property. For example, lets say the following is supposed to return from the API.

```
{
    "employerName": "Microsoft"
}
```

Then use the following syntax

```
Then the response property "employerName" should be "Microsoft" 
```

A more complicated example:

```
{
    "result": {
        "data": {
            "employerName": "Microsoft"
        }
    }
}
```

Then use the following syntax

```
Then the response property "result.data.employerName" should be "Microsoft"
```

### Using Tags

**Use tags to set the base url** for requests. Place a "@baseUrl" tag on any Feature or Scenario and an additional tag to specify the base url to use. 

In the example below, the full url is `http://api-faro-ofstest.ose-elr-core.optum.com/faro/financial/contributions/v1.0`. Since we don't want to type this everytime, we can put the first half the url in the configuration file `lib/config.js` and then reference it as a tag as shown below.

```
@baseUrl @baseUrl-farotest
Feature: Rest API Examples
    This is an example of a REST API spec
    
    Scenario: Example Scenario
    When I make a POST request to "/contributions/v1.0"
    
    .....more.....
```

### Handling Dates

**To use todays date in a spec** you can use an additional step that inserts the date

```
Scenario: Making a request with a timestamp of todays date
    Given The json request data
    """json
    {
        "TransactionDate": ""
    }
    """
    And The property "TransactionDate" is todays date
    When I make a POST request to "/posts"
    Then the response status code should be "201"
```

**To use a date in the future** you can use an additional step that inserts the date

```
Scenario: Making a request with a future date
    Given The json request data
    """json
    {
        "TransactionDate": ""
    }
    """
    And The property "TransactionDate" is a date "3" days in the future
    When I make a POST request to "/posts"
    Then the response status code should be "201"
```

**To use a date in the past** you can use an additional step that inserts the date

```
Scenario: Making a request with a past date
    Given The json request data
    """json
    {
        "TransactionDate": ""
    }
    """
    And The property "TransactionDate" is a date "3" days in the past
    When I make a POST request to "/posts"
    Then the response status code should be "201"
```