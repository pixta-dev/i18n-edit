'use strict'

app = require '../app'
YAMLItemVM = require './yaml-item-vm'

module.exports =
class CollapsibleVM extends YAMLItemVM
  constructor: ->
    super()
    @open = true

  toggleOpen: ->
    @open = !@open
    app.update()
