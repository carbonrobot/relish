'use strict';

const assert = require('assert');

module.exports = function () {

    this.Given(/^The synthetic id "(.*)"$/i, function(id){
        var b = new Buffer(id);
        this.syntheticId = b.toString('base64');
    });

    this.Given(/^The json request data$/i, function (data) {
        this.requestBody = JSON.parse(data);
    });

    this.Given(/^The request data$/i, function (data) {
        const dataRows = data.hashes();
        const firstRow = dataRows[0];
        this.requestBody = firstRow;
    });

    this.When(/^I make a GET request to "(.*)"$/i, function (uri) {
        return this.httpGet(uri);
    });

    this.When(/^I make a DELETE request to "(.*)"$/i, function (uri) {
        return this.httpDelete(uri);
    });

    this.When(/^I make a POST request to "(.*)"$/i, function (uri) {
        return this.httpPost(uri);
    });

    this.Then(/^The response should match "(.*)"$/i, function (expectedResponse, callback) {
        assert.equal(this.actualResponse, expectedResponse, `\r\nExpected ${expectedResponse}\r\nActual ${this.actualResponse}`);
        callback();
    });

    this.Then(/^The response property "(.*)" should have value "(.*)"$/i, function (path, expectedResponse, callback) {
        assert.equal(this.getValue(path), expectedResponse, `\r\nExpected ${expectedResponse}\r\nActual ${this.getValue(path)}\r\n${this.actualResponse}`);
        callback();
    });

    this.Then(/^The response status code should be "(.*)"$/i, function (expectedResponse, callback) {
        assert.equal(this.statusCode, expectedResponse, `\r\nExpected ${expectedResponse}\r\nActual ${this.statusCode}\r\n${this.actualResponse}`);
        callback();
    });

};