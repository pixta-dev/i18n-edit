'use strict'

CollapsibleVM = require './collapsible-vm'

module.exports =
class ArrayVM extends CollapsibleVM
  type: 'array'

  constructor: (@children) ->
    super()
    for child in @children
      child.parent = this

  keyForChild: (child) ->
    String(@children.indexOf(child))
