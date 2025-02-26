@ignore 
Feature: Sign Up New User

    Background: Preconditions
        Given url apiUrl

    Scenario: New User Sign Up
        Given def userData = {"email":"kikiki@test.com","username":"kikiki"}
        
        Given path 'users'
        And request 
        """
            {
            "user": {
                "email": #('Test' + userData.email),
                "password": "1234566",
                "username": #('Test' + userData.username)
                }
            }
        """
        When method Post
        Then status 201