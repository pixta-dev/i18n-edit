'use strict'

_ = require 'lodash'
SearchResultVM = require '../view-models/search-result-vm'

searchItem = (file, item, baseKey, keyPattern, valuePattern) ->
  search = (item, baseKey) ->
    switch item.type
      when 'array'
        debugger
        _.flatten item.children.map (child, index) ->
          search child, "#{baseKey}.#{index}"
      when 'map'
        debugger
        _.flatten _.keys(item.children).map (key) ->
          search item.children[key], "#{baseKey}.#{key}"
      when 'translation'
        debugger
        result = []
        key = baseKey.slice(1)
        for lang, value of item.texts
          if keyPattern?.test key || valuePattern?.test value
            result.push new SearchResultVM(file, item, key, lang)
        result
  search item, baseKey

module.exports =
searchFiles = (files, {key, value}) ->
  _.flatten files.map (file) ->
    searchItem file, file.root, '', key, value
