'use strict'

path = require 'path'
co = require 'co'
EventEmitter = (require 'events').EventEmitter

class App extends EventEmitter
  start: ->
    @windowVM = new WindowVM()
    @files = []
    @folder = ''

  update: ->
    @emit 'update'

  render: ->
    renderWindow(@windowVM)

  setRootFolder: (@folder) -> do co =>
    @files = yield loadDir(@folder)
    @windowVM.clearStates()
    @update()

  saveAll: ->
    for file in @files
      file.save()

module.exports = new App()

loadDir = require './services/load-dir'
renderWindow = require './views/window'
WindowVM = require './view-models/window-vm'
