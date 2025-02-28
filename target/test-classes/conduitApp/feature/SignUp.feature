
Feature: Sign Up New User

    Background: Preconditions
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()
        * url apiUrl

    Scenario: New User Sign Up
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
    
    Scenario Outline: Validate Sign Up Error Message
        Given path 'users'
        And request 
        """
            {
            "user": {
                "email": "<email>",
                "password": "<password>",
                "username": "<username>"
                }
            }
        """
        When method Post
        Then status 422
        And match response == <errorResponse>

        Examples:
            | email            | password  | username          | errorResponse                                      |
            | #(randomEmail)   | Karate123 | cloaiza11         | {"errors":{"username":["has already been taken"]}} |
            | cloaiza@test.com | Karate123 | #(randomUsername) | {"errors":{"email":["has already been taken"]}}    |
            |                  | Karate123 | #(randomUsername) | {"errors":{"email":["can't be blank"]}}            |
            | cloaiza11        |           | #(randomUsername) | {"errors":{"password":["can't be blank"]}}         |
            | cloaiza11        | Karate123 |                   | {"errors":{"username":["can't be blank"]}}         |
