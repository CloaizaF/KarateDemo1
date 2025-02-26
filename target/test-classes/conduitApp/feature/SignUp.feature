Feature: Sign Up New User

    Background: Preconditions
        Given url apiUrl

    @debug 
    Scenario: New User Sign Up
        Given path 'users'
        And request {"user":{"email":"kiloli@test.com","password":"1234566","username":"kiloli"}}
        When method Post
        Then status 201