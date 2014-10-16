'use strict'

ko = require 'knockout'
languageVM = require './language-vm'

module.exports =
class TranslationVM

  constructor: (texts) ->
    @type = 'translation'
    @texts = ko.computed =>
      languageVM.names().map (lang) =>
        texts[lang]
