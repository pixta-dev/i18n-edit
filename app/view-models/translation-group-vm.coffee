ko = require 'knockout'
_ = require 'lodash'
util = require '../util'
TranslationVM = require './translation-vm'

class TranslationGroupVM
  constructor: ->
    @type = 'group'
    @key = ko.observable()
    @children = ko.observableArray()
    @childrenObj = {}
    @open = ko.observable false

  insert: (translation, keys) ->
    keys ?= translation.path.split('.')
    key = keys[0]
    if keys.length == 1
      child = new TranslationVM(translation)
      @children.push child
      @childrenObj[key] = child
    else
      child = @childrenObj[key]
      unless child?
        child = new TranslationGroupVM()
        child .key key
        @children.push child
        @childrenObj[key] = child
      child.insert translation, keys.slice(1)

module.exports = TranslationGroupVM
