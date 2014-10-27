'use strict'

YAMLItemVM = require './yaml-item-vm'

module.exports =
class TranslationVM extends YAMLItemVM
  type: 'translation'
  constructor: (@texts) ->

  setText: (lang, value) ->
    @texts[lang] = value
    @file.save(lang)
