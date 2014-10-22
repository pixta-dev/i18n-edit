'use strict'

CollapsibleVM = require './collapsible-vm'

module.exports =
class MapVM extends CollapsibleVM

  constructor: (@children) ->
    super()

MapVM::type = 'map'
