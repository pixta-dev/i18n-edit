'use strict'

path = require 'path'
co = require 'co'
dumpYAML = require '../services/dump-yaml-files'
computed = (require '../util').computedProperty
app = require '../app'
langs = (require './language-vm').names

module.exports =
class FileVM
  type: 'file'

  computed @, 'title', -> path.join(path.relative(app.folder, @dir), @name)

  constructor: (@dir, @name, @root, @errors) ->
    @root.file = this

  save: (lang) -> do co =>
    yield dumpYAML @dir, @name, this, [lang]

  saveAll: -> do co =>
    yield dumpYAML @dir, @name, this, langs
