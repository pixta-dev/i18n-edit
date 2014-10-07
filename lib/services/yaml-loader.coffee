'use strict'

co = require 'co'
thunkify = require 'thunkify'
fs = require 'fs'
yaml = require 'js-yaml'
File = require '../models/file'
Translation = require '../models/translation'
Text = require '../models/text'
Language = require '../models/language'

findOrCreate = (model, data) -> co ->
  existing = yield model.find where: data
  existing ?= yield model.create data

class YamlLoader
  constructor: (@path, @files) ->

  load: ->
    co =>
      @file = yield File.create
        path: @path
      for file in @files
        data = yield thunkify(fs.readFile) file, encoding: 'utf-8'
        tree = yaml.safeLoad data
        for key, value of tree
          @language = yield findOrCreate Language,
            name: key
          yield @loadTree('', value)
      undefined # workaround for https://github.com/jashkenas/coffeescript/issues/3665

  loadTree: (baseKey, tree) ->
    co =>
      for key in Object.keys(tree)
        item = tree[key]
        fullKey = baseKey + key
        switch
          when typeof item == 'string'
            yield @loadValue fullKey, null, item
          when Array.isArray item
            for elem, i in item
              yield @loadValue fullKey, i, elem
          else
            yield @loadTree fullKey + '.', item
      undefined

  loadValue: (fullKey, index, value) ->
    co =>
      translation = yield findOrCreate Translation,
        FileId: @file.id
        path: fullKey
        index: index
      yield Text.create
        value: value
        LanguageId: @language.id
        TranslationId: translation.id

module.exports = YamlLoader
