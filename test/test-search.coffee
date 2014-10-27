'use strict'

co = require 'co'
assert = (require 'chai').assert
search = require '../app/services/search'
shared = require './shared'
SearchResultVM = require '../app/view-models/search-result-vm'

describe 'search', ->

  fileVM = null

  beforeEach co ->
    fileVM = yield shared.loadTestYAMLs()

  it 'searches translations from key and value pattern', ->
     results = search [fileVM], key: /accepted/
     assert.equal results[0].file, fileVM
     assert.equal results[0].fullKey, 'errors.messages.accepted'
     assert.equal results[0].text, 'must be accepted'
     assert.equal results[0].language, 'en'
