'use strict'

assert = require 'assert'
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
    assert.equal 'test', fileVM.path()
    root = fileVM.root()
    hoge = root.childrenObject().hoge
    piyo = hoge.childrenObject().piyo
    assert.equal piyo.texts().ja, 'ぴよ'
    assert.equal piyo.texts().en, 'Piyo'

    array = hoge.childrenObject().array.children()
    assert.equal array[0].texts().ja, 'ほげ'
    assert.equal array[1].texts().ja, 'ぴよ'
    assert.equal array[0].texts().en, 'Hoge'
    assert.equal array[1].texts().en, 'Piyo'
