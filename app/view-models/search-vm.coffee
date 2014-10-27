'use strict'

search = require '../services/search'
app = require '../app'

module.exports =
class SearchVM
  type: 'search'
  constructor: (@key, @value) ->
    @results = search app.files, {key: new RegExp(@key), value: new RegExp(@value)}
    @title = "検索"
    if key?
      @title += " キー: '#{key}'"
    if value?
      @title += " 値: '#{value}'"
