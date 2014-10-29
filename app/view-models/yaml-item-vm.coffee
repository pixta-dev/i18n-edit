'use strict'

util = require '../util'
module.exports =
class YAMLItemVM

  Object.defineProperty @::, 'path',
    get: ->
      path = if @parent?
        parentPath = @parent.path
        if parentPath == ''
          @parent.keyForChild(this)
        else
          "#{@parent.path}.#{@parent.keyForChild(this)}"
      else
        ''

  Object.defineProperty @::, 'file',
    get: ->
      @_file ? @parent?.file
    set: (@_file) ->

  constructor: ->
    @parent = null
