'use strict'

computed = (require '../util').computedProperty

module.exports =
class SearchResultVM

  computed @, 'text', ->
    @translation.texts[@language]

  constructor: (@file, @translation, @fullKey, @language) ->
