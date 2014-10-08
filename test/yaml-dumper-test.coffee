'use strict'

path = require 'path'
co = require 'co'
mockFs = require 'mock-fs'
util = require '../lib/util'
dbSync = require '../lib/db/sync'
YamlLoader = require '../lib/services/yaml-loader'
YamlDumper = require '../lib/services/yaml-dumper'
File = require '../lib/models/file'

assert = (require 'chai').assert

describe 'YamlDumper', ->

  ['basic', 'array'].forEach (type) ->

    describe '#dump', ->

      beforeEach co ->
        yield dbSync.sync()

      afterEach co ->
        yield dbSync.drop()

      beforeEach co ->
        files = ['en', 'ja'].map (lang) ->
          path.join(__dirname, "fixtures/#{type}.#{lang}.yml")
        loader = new YamlLoader(type, files)
        yield loader.load()

      it "dumps YAML files: #{type}", co ->
        mockFs
          mock: {}

        file = (yield File.all())[0]
        dumper = new YamlDumper('mock', file)
        yield dumper.dump()

        langs = ['en', 'ja']

        actual = {}
        for lang in langs
          actual[lang] = yield util.loadYAMLFile "mock/#{type}.#{lang}.yml"

        mockFs.restore()

        expected = {}
        for lang in langs
          expected[lang] = yield util.loadYAMLFile path.join(__dirname, "fixtures/#{type}.#{lang}.yml")

        for lang in langs
          assert.deepEqual actual[lang], expected[lang]
