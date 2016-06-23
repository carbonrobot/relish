relish
---------------

REST API Testing with javascript and cucumber

## Getting Started

The following software must be installed for development.

- Install Node.js 4.5+

After Nodejs is installed, open your shell window and clone this repository into your projects folder.

```bash
$ git clone https://github.com/carbonrobot/relish
$ cd relish
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
$ npm test features/examples/examples.feature
```


To run a single test in a feature file, run the following command from the project directory. 
In this example "23" is the line number of the test in the file.

```bash
$ npm test features/examples/examples.feature:23
```

## Writing Tests

Place new feature files in the `features` folder. Features can and should be organized into folders.

Refer to the `features/examples.feature` file for examples of what is possible with this framework.

