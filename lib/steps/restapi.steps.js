'use strict';

const _ = require('lodash');
const assert = require('assert');
const moment = require('moment');

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

    this.Given(/^The property "(.*)" is todays date$/, function(path){
        const ts = moment().format('MM-DD-YYYY');
        _.set(this.requestBody, path, ts);
    });

    this.Given(/^The property "(.*)" is todays date with format "(.*)"$/, function(path, format){
        const ts = moment().format(format);
        _.set(this.requestBody, path, ts);
    });

    this.Given(/^The property "(.*)" is a date "(\d*)" days in the future$/, function(path, days){
        const ts = moment().add(days, 'day').format('MM-DD-YYYY');
        _.set(this.requestBody, path, ts);
    });

    this.Given(/^The property "(.*)" is a date "(\d*)" days in the past$/, function(path, days){
        const ts = moment().subtract(days, 'day').format('MM-DD-YYYY');
        _.set(this.requestBody, path, ts);
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