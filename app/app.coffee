'use strict'

path = require 'path'
co = require 'co'
EventEmitter = (require 'events').EventEmitter

class App extends EventEmitter
  start: ->
    @windowVM = new WindowVM()

  update: ->
    @emit 'update'

  render: ->
    renderWindow(@windowVM)

module.exports = new App()

renderWindow = require './views/window'
WindowVM = require './view-models/window-vm'
