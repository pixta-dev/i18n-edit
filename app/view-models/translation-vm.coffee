ko = require 'knockout'
_ = require 'lodash'
co = require 'co'
Language = require '../models/language'

class TranslationVM

  constructor: ->
    @type = 'translation'
    @texts = ko.observableArray()
    @key = ko.observable()
    @index = ko.observable()

  loadTranslation: (@translation) -> co =>
    @key _.last @translation.path.split('.')
    @index @translation.index

    langs = yield Language.all()
    texts = yield langs.map (lang) =>
      text = (yield @translation.getTexts(where: { languageId: lang.id }))[0]
      if text?
        text.value
      else
        ''
    @texts texts

module.exports = TranslationVM
