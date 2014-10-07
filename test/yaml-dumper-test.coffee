'use strict'

assert = require 'assert'
path = require 'path'
co = require 'co'
mockFs = require 'mock-fs'
deepEqual = require 'deep-equal'
util = require '../lib/util'
dbSync = require '../lib/db/sync'
YamlLoader = require '../lib/services/yaml-loader'
YamlDumper = require '../lib/services/yaml-dumper'
File = require '../lib/models/file'

describe 'YamlDumper', ->

  beforeEach co ->
    yield dbSync.sync()

  afterEach co ->
    yield dbSync.drop()

  beforeEach co ->
    files = ['en', 'ja'].map (lang) ->
      path.join(__dirname, "fixtures/basic.#{lang}.yml")
    loader = new YamlLoader('basic', files)
    yield loader.load()

  describe '#dump', ->

    it 'dumps YAML files', co ->
      mockFs
        mock: {}

      file = (yield File.all())[0]
      dumper = new YamlDumper('mock', file)
      yield dumper.dump()

      langs = ['en', 'ja']

      actual = {}
      for lang in langs
        actual[lang] = yield util.loadYAMLFile "mock/basic.#{lang}.yml"

      mockFs.restore()

      expected = {}
      for lang in langs
        expected[lang] = yield util.loadYAMLFile path.join(__dirname, "fixtures/basic.#{lang}.yml")

      for lang in langs
        assert deepEqual actual[lang], expected[lang]
