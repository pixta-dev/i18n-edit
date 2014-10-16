'use strict'

global.document = window.document
global.navigator = window.navigator

path = require 'path'
ko = require 'knockout'
glob = require 'glob'
$ = require 'jquery'
co = require 'co'
thunkify = require 'thunkify'
fs = require 'fs'
loadYAMLFiles = require './services/load-yaml-files'

loadTemplates = -> co ->
  files = yield thunkify(glob)("#{__dirname}/../dist/views/templates/*.html")
  for file in files
    name = path.basename file, '.html'
    data = yield thunkify(fs.readFile) file, encoding: 'utf-8'
    template = "<script type='text/html' id='#{name}-template'>#{data}</script>"
    $('body').append(template)

do co ->
  yield loadTemplates()

  files = ['en', 'ja'].map (lang) ->
    path.join(__dirname, "../test/fixtures/rails-i18n/rails-i18n.#{lang}.yml")

  vm = yield loadYAMLFiles('rails-i18n', files)
  ko.applyBindings vm, $('body')[0]
