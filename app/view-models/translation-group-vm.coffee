ko = require 'knockout'
_ = require 'lodash'
util = require '../util'
TranslationVM = require './translation-vm'

class TranslationGroupVM
  constructor: ->
    @type = 'group'
    @key = ko.observable()
    @children = ko.observableArray()
    @open = ko.observable false

  insert: (translation, keys) ->
    keys ?= translation.path.split('.')
    key = keys[0]
    if keys.length == 1
      @children.push new TranslationVM(translation)
    else
      childVM = new TranslationGroupVM()
      childVM.key key
      childVM.insert translation, keys.slice(1)
      @children.push childVM

module.exports = TranslationGroupVM
