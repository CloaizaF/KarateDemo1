@debug
Feature: Sign Up New User

    Background: Preconditions
        * def dataGenerator = Java.type('helpers.DataGenerator')
        Given url apiUrl

    Scenario: New User Sign Up
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()
        
        Given path 'users'
        And request 
        """
            {
            "user": {
                "email": #(randomEmail),
                "password": "1234566",
                "username": #(randomUsername)
                }
            }
        """
        When method Post
        Then status 201
        And match response ==
        """
            {
                "user": {
                    "id": "#number",
                    "email": #(randomEmail),
                    "username": #(randomUsername),
                    "bio": "##string",
                    "image": "##string",
                    "token": "#string"
                }
            }
        """