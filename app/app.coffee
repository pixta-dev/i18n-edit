'use strict'

path = require 'path'
co = require 'co'
EventEmitter = (require 'events').EventEmitter

module.exports =
class App extends EventEmitter
  @start: ->
    @instance = new App()

  constructor: ->
    do co =>
      files = ['en', 'ja'].map (lang) =>
        path.join(__dirname, "../test/fixtures/rails-i18n/rails-i18n.#{lang}.yml")

      @fileVM = yield loadYAMLFiles(path.join(__dirname, '../test/fixtures/rails-i18n/'), 'rails-i18n', files)
      @update()

  update: ->
    @emit 'update'

  render: ->
    renderFileTable(@fileVM)

loadYAMLFiles = require './services/load-yaml-files'
renderFileTable = require './views/file-table'
