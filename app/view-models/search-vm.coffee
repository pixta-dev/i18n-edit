'use strict'

search = require '../services/search'
app = require '../app'

module.exports =
class SearchVM
  type: 'search'
  constructor: (@key, @value) ->
    pattern = {}
    unless @key == ''
      pattern.key = new RegExp(@key)
    unless @value == ''
      pattern.value = new RegExp(@value)

    @results = search app.files, pattern
    @title = "検索"
    if key?
      @title += " キー: '#{key}'"
    if value?
      @title += " 値: '#{value}'"
