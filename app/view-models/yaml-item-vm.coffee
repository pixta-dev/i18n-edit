'use strict'

util = require '../util'
module.exports =
class YAMLItemVM

  Object.defineProperty @::, 'path',
    get: ->
      path = if @parent?
        "#{@parent.path}.#{@parent.keyForChild(this)}"
      else
        ''
      path.slice(1)

  Object.defineProperty @::, 'file',
    get: ->
      @_file ? @parent?.file
    set: (@_file) ->

  constructor: ->
    @parent = null
