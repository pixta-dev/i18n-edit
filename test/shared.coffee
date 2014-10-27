'use strict'

path = require 'path'
co = require 'co'
loadYAML = require '../app/services/load-yaml-files'

module.exports =
  loadTestYAMLs: -> co ->
    files = ['en', 'ja'].map (lang) ->
      path.join(__dirname, "fixtures/rails-i18n/rails-i18n.#{lang}.yml")
    yield loadYAML path.join(__dirname, "fixtures"), 'test', files
