Feature: Tests for the home page

    Background: Define URL
        Given url apiUrl

    @ignore
    Scenario: Create a new article
        Given path 'articles'
        And request {"article": {"title": "test1134","description": "testDesc","body": "testBody","tagList": ["test"]}}
        When method Post
        Then status 201
        And match response.article.title == 'test1134'
   
    Scenario: Create and Delete article
        Given path 'articles'
        And request {"article": {"title": "artToDelete","description": "testDesc","body": "testBody","tagList": ["test"]}}
        When method Post
        Then status 201
        * def articleId = response.article.slug

        Given params { limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title == 'artToDelete'

        Given path 'articles', articleId
        When method Delete
        Then status 204

        Given params { limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != 'artToDelete'

