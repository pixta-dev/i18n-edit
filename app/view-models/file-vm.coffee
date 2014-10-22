'use strict'

co = require 'co'
dumpYAML = require '../services/dump-yaml-files'
computed = (require '../util').computedProperty

module.exports =
class FileVM
  type: 'file'

  computed @, 'title', -> @dir + @name

  constructor: (@dir, @name, @root) ->

  save: -> do co =>
    yield dumpYAML @dir, @name, this
