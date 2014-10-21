'use strict'

app = require '../app'

module.exports =
class CollapsibleVM
  constructor: ->
    @open = true

  toggleOpen: ->
    @open = !@open
    app.update()
