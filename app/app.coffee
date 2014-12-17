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
    try
      files = yield loadDir(@folder)
    catch error
      window.alert "フォルダのロードに失敗しました: #{error}"
      return

    window.localStorage.rootFolder = @folder
    @files = files
    @windowVM.clearStates()
    @update()

  reloadAll: ->
    @setRootFolder @folder

module.exports = new App()

loadDir = require './services/load-dir'
renderWindow = require './views/window'
WindowVM = require './view-models/window-vm'
