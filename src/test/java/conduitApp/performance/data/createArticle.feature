Feature: Performance tests for the home page

Background: Define URL
    * url apiUrl
    * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set articleRequestBody.article.title = dataGenerator.getRandomArticleValues().title
    * set articleRequestBody.article.description = dataGenerator.getRandomArticleValues().description
    * set articleRequestBody.article.body = dataGenerator.getRandomArticleValues().body

Scenario: Create and Delete article
    Given path 'articles'
    And request articleRequestBody
    When method Post
    Then status 201
    * def articleId = response.article.slug

    Given path 'articles', articleId
    When method Delete
    Then status 204