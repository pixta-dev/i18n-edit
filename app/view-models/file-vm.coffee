ko = require 'knockout'
co = require 'co'
TranslationGroupVM = require './translation-group-vm'
Language = require '../models/language'


class FileVM

  constructor: ->
    @root = new TranslationGroupVM
    @root.key('[Root]')
    @languages = ko.observableArray()

  loadFile: (@file) ->
    do co =>
      @languages (yield Language.all()).map (lang) => lang.name

      @path = ko.observable @file.path
      for t in yield @file.getTranslations()
        @root.insert t


module.exports = FileVM
