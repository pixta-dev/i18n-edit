'use strict'

ko = require 'knockout'

langs = ko.observableArray()

module.exports =
  names: langs
  add: (name) ->
    if langs().indexOf(name) < 0
      langs.push(name)
