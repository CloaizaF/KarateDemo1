Feature: Homework

    Background: Preconditions
        * url apiUrl

    @ignore
    Scenario: Favorite articles
        Given path 'articles'
        Given params { limit: 10, offset: 0 }
        When method Get
        Then status 200
        * def slug = response.articles[0].slug
        * def favoritesCountIntial = response.articles[0].favoritesCount

        * def isValidTime = read('classpath:helpers/timeValidator.js')

        Given path 'articles/' + slug +'/favorite'
        And request {}
        When method Post
        Then status 200
        And match response == 
        """
            {
                "article": {
                    "id": "#number",
                    "slug": #(slug),
                    "title": "#string",
                    "description": "#string",
                    "body": "#string",
                    "createdAt": "#? isValidTime(_)",
                    "updatedAt": "#? isValidTime(_)",
                    "authorId": "#number",
                    "tagList": "#array",
                    "author": {
                        "username": "#string",
                        "bio": "##string",
                        "image": "##string",
                        "following": "##boolean"
                    },
                    "favoritedBy": [
                        {
                            "id": "#number",
                            "email": "#string",
                            "username": "#string",
                            "password": "#string",
                            "image": "##string",
                            "bio": "##string",
                            "demo": "##boolean"
                        }
                    ],
                    "favorited": "#boolean",
                    "favoritesCount": "#number"
                }
            }
        """
