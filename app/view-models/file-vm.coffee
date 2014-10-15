ko = require 'knockout'
co = require 'co'
TranslationGroupVM = require './translation-group-vm'
Language = require '../models/language'


class FileVM

  constructor: ->
    @root = ko.observable(new TranslationGroupVM)
    @languages = ko.observableArray()

  loadFile: (@file) -> co =>
    root = new TranslationGroupVM
    root.key('[Root]')
    @languages (yield Language.all()).map (lang) => lang.name

    @path = ko.observable @file.path
    for t in yield @file.getTranslations()
      yield root.insert t

    @root root

module.exports = FileVM
