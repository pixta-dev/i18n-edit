'use strict'

path = require 'path'
co = require 'co'
EventEmitter = (require 'events').EventEmitter

class App extends EventEmitter
  start: ->
    @windowVM = new WindowVM()
    @files = []
    @folder = ''

    folder = window.localStorage.rootFolder
    if folder
      @setRootFolder(folder)

  update: ->
    @emit 'update'

  render: ->
    renderWindow(@windowVM)

  setRootFolder: (@folder) -> do co =>
    window.localStorage.rootFolder = @folder
    @files = yield loadDir(@folder)
    @windowVM.clearStates()
    @update()

  reloadAll: ->
    @setRootFolder @folder

  saveAll: ->
    for file in @files
      file.save()

module.exports = new App()

loadDir = require './services/load-dir'
renderWindow = require './views/window'
WindowVM = require './view-models/window-vm'
