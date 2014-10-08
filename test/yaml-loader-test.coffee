'use strict'

assert = require 'assert'
path = require 'path'
co = require 'co'
dbSync = require '../app/db/sync'
YamlLoader = require '../app/services/yaml-loader'

File = require '../app/models/file'
Translation = require '../app/models/translation'
Text = require '../app/models/text'
Language = require '../app/models/language'

describe 'YamlLoader', ->

  beforeEach co ->
    yield dbSync.sync()

  afterEach co ->
    yield dbSync.drop()

  describe '#load', ->

    beforeEach co ->
      files = ['en', 'ja'].map (lang) ->
        path.join(__dirname, "fixtures/basic.#{lang}.yml")
      loader = new YamlLoader('basic', files)
      yield loader.load()

    it 'loads languages', co ->
      langs = yield Language.all()

      assert.equal langs.length, 2
      assert.equal langs[0].name, 'en'
      assert.equal langs[1].name, 'ja'

    it 'loads file', co ->
      files = yield File.all()

      assert.equal files.length, 1
      assert.equal files[0].path, 'basic'

    it 'loads translations', co ->
      file = yield File.find where: { path: 'basic' }
      translations = yield Translation.all()

      assert.equal translations.length, 1
      assert.equal translations[0].path, 'hoge.piyo'
      assert (yield translations[0].getFile()).equals file

    it 'loads texts', co ->
      translation = yield Translation.find where: { path: 'hoge.piyo' }
      en = yield Language.find where: { name: 'en' }
      ja = yield Language.find where: { name: 'ja' }
      texts = yield Text.all()

      assert.equal texts.length, 2

      assert (yield texts[0].getLanguage()).equals en
      assert (yield texts[0].getTranslation()).equals translation
      assert.equal texts[0].value, 'Piyo'

      assert (yield texts[1].getLanguage()).equals ja
      assert (yield texts[1].getTranslation()).equals translation
      assert.equal texts[1].value, 'ぴよ'

  describe '#load with YAML array', ->

    beforeEach co ->
      files = ['en', 'ja'].map (lang) ->
        path.join(__dirname, "fixtures/array.#{lang}.yml")
      loader = new YamlLoader('array', files)
      yield loader.load()

    it 'loads translations with indexes', co ->
      translations = yield Translation.all()

      assert.equal translations.length, 2
      assert.equal translations[0].path, 'hoge.piyo'
      assert.equal translations[0].index, 0
      assert.equal translations[1].path, 'hoge.piyo'
      assert.equal translations[1].index, 1
