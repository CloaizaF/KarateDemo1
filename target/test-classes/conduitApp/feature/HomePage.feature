
Feature: Tests for the home page

    Background: Define URL
        Given url apiUrl
    
    Scenario: Get all tags
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags == "#array"
        And match each response.tags == "#string"

    Scenario: Get 10 articles from the page
        * def isValidTime = read('classpath:helpers/timeValidator.js')
        Given params { limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        And match response == {"articles": "#[10]", "articlesCount": "#number"}
        And match each response.articles ==
        """
            {
                "slug": "#string",
                "title": "#string",
                "description": "#string",
                "body": "#string",
                "tagList": "#array",
                "createdAt": "#? isValidTime(_)",
                "updatedAt": "#? isValidTime(_)",
                "favorited": "#boolean",
                "favoritesCount": "#number",
                "author": {
                    "username": "#string",
                    "bio": "##string",
                    "image": "#string",
                    "following": "#boolean"
                }
            }
        """

    @debug
    Scenario: Conditional Logic
        Given params { limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        * def favoritesCount = response.articles[0].favoritesCount
        * def article = response.articles[0]

        #* if (favoritesCount == 0) karate.call('classpath:helpers/AddLikes.feature', article)

        * def result = favoritesCount == 0 ? karate.call('classpath:helpers/AddLikes.feature', article).likesCount : favoritesCount
        
        Given params { limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].favoritesCount == result
