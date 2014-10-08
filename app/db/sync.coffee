'use strict'
co = require 'co'

models = [
  require '../models/file'
  require '../models/translation'
  require '../models/text'
  require '../models/language'
]

module.exports =
  sync: -> co ->
    for model in models
      yield model.sync()

  drop: -> co ->
    for model in models
      yield model.drop()
