relish
---------------

REST API Testing with Cucumber and Javascript

## Getting Started

The following software must be installed for development.

- Nodejs, 4.x+

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
@baseUrl @baseUrl-examples
Scenario: Make a payment to a bill provider
    And The json request data
    """json
    {
        "amount": "133.0",
        "TransactionDate": "01-09-2016" 
    }
    """
    And the property "TransactionDate" is a date "3" days in the future
    When I make a POST request to "/payments/v1.0"
    Then the response status code should be "200"
    And the response property "data.results[0].status" should be "Pending"
```

### Verify results

**To verify the status code of a response**, use the following

```
Then the response status code should be "404"
```

**To verify a simple response** containing a single word or value, use the following

```
Then the response should be "Completed"
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

Also handles array syntax

```
{
    "result": {
        "data": [{
            "employerName": "Microsoft"
        }, {
            "employerName": "Stripe"   
        }]
    }
}
```

Then use the following syntax

```
Then the response property "result.data[1].employerName" should be "Stripe"
```

### Using Tags to set the base url

**Use tags to set the base url** for requests. Place a "@baseUrl" tag on any Feature or Scenario and an additional tag to specify the base url to use. 

In the example below, the full url is `http://somemagic.com/api/explorer`. Since we don't want to type this everytime, we can put the first half the url in the configuration file `lib/config.js` and then reference it as a tag as shown below.

```
@baseUrl @baseUrl-examples
Feature: Rest API Examples
    This is an example of a REST API spec
    
    Scenario: Example Scenario
    When I make a POST request to "/contributions/v1.0"
    
    .....more.....
```