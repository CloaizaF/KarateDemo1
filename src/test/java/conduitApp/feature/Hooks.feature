@debug
Feature: Hooks

    Background: hooks
        # before hooks
        * def result = callonce read('classpath:helpers/Dummy.feature')
        * def email = result.email
        # call for the each scenario
        # callonce for the entire feature

        # after hooks
        * configure afterScenario = function(){ karate.call('classpath:helpers/Dummy.feature') }
        * configure afterFeature = 
        """
            function(){
                karate.log('After Feature Text');
            }
        """
        # afterFeature for the entire feature
        # afterScenario for each scenario

    Scenario: First scenario
        * print email
        * print 'This is the first scenario'
        
         
    Scenario: Second scenario
        * print email
        * print 'This is the second scenario'