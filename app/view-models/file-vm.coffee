'use strict'

path = require 'path'
co = require 'co'
dumpYAML = require '../services/dump-yaml-files'
computed = (require '../util').computedProperty
app = require '../app'

module.exports =
class FileVM
  type: 'file'

  computed @, 'title', -> path.relative(app.folder, @dir) + @name

  constructor: (@dir, @name, @root) ->
    @root.file = this

  save: (lang) -> do co =>
    yield dumpYAML @dir, @name, this, [lang]
