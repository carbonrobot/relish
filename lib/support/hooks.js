'use strict';

const config = require('../config.js');

module.exports = function(){

    /**
     * Sets up a hook to configure the base url for a scenario.
     * The key of which is a configuration value in the config.baseUrl section.
     * 
     * Example
     * @baseUrl @baseUrl-examples
     * Scenario: An example scenario name
     */
    this.Before({tags: ["@baseUrl"]}, function(scenario){
        const tags = scenario.getTags();
        for(let i = 0; i < tags.length; i++){
            const name = tags[i].getName();
            if(name.includes('baseUrl-')){
                const value = name.split('-')[1];
                this.baseUrl = config.baseUrl[value];
                return;
            }
        }
    });

};