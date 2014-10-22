'use strict'

path = require 'path'
co = require 'co'
assert = (require 'chai').assert
loadDir = require '../app/services/load-dir'

describe 'loadDir', ->

  it 'loads all YAML files in a directory', co ->
    dir = path.join(__dirname, 'fixtures')
    files = yield loadDir dir

    assert.equal files[0].dir, path.join(__dirname, 'fixtures/rails-i18n')
    assert.equal files[0].name, 'rails-i18n'

    assert.equal files[1].dir, path.join(__dirname, 'fixtures')
    assert.equal files[1].name, 'test'
