'use strict'

path = require 'path'
co = require 'co'
assert = (require 'chai').assert

loadYAML = require '../app/services/load-yaml-files'

describe 'loadYAMLFiles', ->

  fileVM = null

  beforeEach co ->
    files = ['en', 'ja'].map (lang) ->
      path.join(__dirname, "fixtures/test.#{lang}.yml")
    fileVM = yield loadYAML 'test', files

  it 'loads YAML into a FileVM', ->
    assert.equal 'test', fileVM.path
    root = fileVM.root
    hoge = root.children.hoge
    piyo = hoge.children.piyo
    assert.deepEqual piyo.texts,
      en: 'Piyo'
      ja: 'ぴよ'

    array = hoge.children.array.children
    assert.deepEqual array[0].texts,
      en: 'Hoge'
      ja: 'ほげ'
    assert.deepEqual array[1].texts,
      en: 'Piyo'
      ja: 'ぴよ'
