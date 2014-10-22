'use strict'

CollapsibleVM = require './collapsible-vm'

module.exports =
class MapVM extends CollapsibleVM
  type: 'map'

  constructor: (@children) ->
    super()
