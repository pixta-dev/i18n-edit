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
    assert.deepEqual piyo.texts(), ['Piyo', 'ぴよ']

    array = hoge.childrenObject().array.childrenArray()
    assert.deepEqual array[0].texts(), ['Hoge', 'ほげ']
    assert.deepEqual array[1].texts(), ['Piyo', 'ぴよ']
