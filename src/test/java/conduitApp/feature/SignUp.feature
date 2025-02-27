@debug
Feature: Sign Up New User

    Background: Preconditions
        * def dataGenerator = Java.type('helpers.DataGenerator')
        Given url apiUrl

    Scenario: New User Sign Up
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()

        * def jsFunction = 
        """
            function () {
                var DataGenerator = Java.type('helpers.DataGenerator')
                var generator = new DataGenerator()
                return generator.getRandomUsername2()
            }
        """
        * def randomUsername2 = call jsFunction
        
        Given path 'users'
        And request 
        """
            {
            "user": {
                "email": #(randomEmail),
                "password": "1234566",
                "username": #(randomUsername2)
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
                    "username": #(randomUsername2),
                    "bio": "##string",
                    "image": "##string",
                    "token": "#string"
                }
            }
        """