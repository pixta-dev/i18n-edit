'use strict'

co = require 'co'
dumpYAML = require '../services/dump-yaml-files'

module.exports =
class FileVM
  constructor: (@dir, @name, @root) ->

  save: -> do co =>
    yield dumpYAML @dir, @name, this

FileVM::type = 'file'

Object.defineProperty FileVM::, 'title',
  get: -> @dir + @name
