'use strict'

co = require 'co'
dumpYAML = require '../services/dump-yaml-files'
computed = (require '../util').computedProperty

module.exports =
class FileVM
  type: 'file'

  computed @, 'title', -> @dir + @name

  constructor: (@dir, @name, @root) ->

  setText: (translation, lang, value) ->
    translation.texts[lang] = value
    @save(lang)

  save: (lang) -> do co =>
    yield dumpYAML @dir, @name, this, [lang]
