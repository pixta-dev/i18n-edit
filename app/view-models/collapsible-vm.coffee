'use strict'

App = require '../app'

module.exports =
class CollapsibleVM
  constructor: ->
    @open = true

  toggleOpen: ->
    @open = !@open
    App.instance.update()
