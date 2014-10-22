'use strict'

CollapsibleVM = require './collapsible-vm'

module.exports =
class ArrayVM extends CollapsibleVM
  type: 'array'

  constructor: (@children) ->
    super()
