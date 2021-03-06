'use strict'

path = require 'path'
co = require 'co'
mockFs = require 'mock-fs'
util = require '../app/util'
loadYAML = require '../app/services/load-yaml-files'
dumpYAML = require '../app/services/dump-yaml-files'

assert = (require 'chai').assert

describe 'dumpYAMLFiles', ->

  fileVM = null

  beforeEach co ->
    files = ['en', 'ja'].map (lang) ->
      path.join(__dirname, "fixtures/rails-i18n/rails-i18n.#{lang}.yml")
    fileVM = yield loadYAML path.join(__dirname, "fixtures"), 'test', files

  ['en', 'ja'].forEach (lang) ->

    it "dumps YAML files (#{lang})", co ->
      mockFs
        mock: {}

      yield dumpYAML 'mock', 'test', fileVM
      actual = yield util.loadYAMLFile "mock/test.#{lang}.yml"
      mockFs.restore()

      expected = yield util.loadYAMLFile path.join(__dirname, "fixtures/rails-i18n/rails-i18n.#{lang}.yml")
      assert.deepEqual actual, expected
