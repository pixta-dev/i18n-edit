'use strict'

ko = require 'knockout'

class TranslationVM

  constructor: (texts) ->
    @texts = ko.observable(texts)

module.exports = TranslationVM
