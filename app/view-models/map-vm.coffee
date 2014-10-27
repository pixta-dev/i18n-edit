'use strict'

CollapsibleVM = require './collapsible-vm'

module.exports =
class MapVM extends CollapsibleVM
  type: 'map'

  constructor: (@children) ->
    super()
    for own key, child of @children
      child.parent = this

  keyForChild: (child) ->
    for own key, value of @children
      if child == value
        return key
    null
