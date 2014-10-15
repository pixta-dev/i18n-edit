'use strict'

languages = []

module.exports =
  all: -> languages
  add: (lang) ->
    if languages.indexOf(lang) < 0
      languages.push lang
