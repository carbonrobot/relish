'use strict';

const _ = require('lodash');
const http = require('request-promise');

function World() {
    const self = this;

    /**
     * Performs an HTTP GET request to the given uri
     */
    this.httpGet = function (uri) {
        // check for synthetic id, and append to request if needed
        if(self.syntheticId){
            uri = uri.replace('{syntheticId}', self.syntheticId);
        }
        return _httpRequest({ method: 'GET', uri: uri });
    };

    /**
     * Performs an HTTP DELETE request to the given uri
     */
    this.httpDelete = function (uri) {
        // check for synthetic id, and append to request if needed
        if(self.syntheticId){
            uri = uri.replace('{syntheticId}', self.syntheticId);
        }
        return _httpRequest({ method: 'DELETE', uri: uri });
    };

    /**
     * Performs an HTTP POST request to the given uri
     */
    this.httpPost = function (uri) {
        // check for synthetic id, and append to request if needed
        if(self.syntheticId){
            self.requestBody.syntheticId = self.syntheticId;
        }
        return _httpRequest({ method: 'POST', uri: uri });
    };

    /**
     * Gets the value of a property by its path
     */
    this.getValue = function(path){
        return _.get(self.actualResponse, path);
    };

    /**
     * Internal http request generator
     */
    function _httpRequest(options){
        return http({
            method: options.method,
            uri: options.uri,
            body: self.requestBody,
            json: true,
            resolveWithFullResponse: true
        }).then(function(response) {
            self.actualResponse = response.body;
            self.statusCode = response.statusCode;
        }, function(response){
            self.actualResponse = response.body;
            self.statusCode = response.statusCode;
        });
    }
}

module.exports = function () {
    this.World = World;
};