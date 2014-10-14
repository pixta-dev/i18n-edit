ko = require 'knockout'
_ = require 'lodash'
co = require 'co'
Language = require '../models/language'

class TranslationVM

  constructor: (@translation) ->
    @type = 'translation'
    @texts = ko.observableArray()
    @key = ko.observable _.last @translation.path.split('.')
    @index = ko.observable @translation.index
    do co =>
      langs = yield Language.all()
      texts = yield langs.map (lang) =>
        text = (yield @translation.getTexts(where: { languageId: lang.id }))[0]
        if text?
          text.value
        else
          ''
      @texts texts

module.exports = TranslationVM
