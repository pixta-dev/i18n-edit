'use strict'

CollapsibleVM = require './collapsible-vm'

module.exports =
class ArrayVM extends CollapsibleVM

  constructor: (@children) ->
    super()
    @type = 'array'
