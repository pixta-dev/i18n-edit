'use strict'
path = require 'path'
fs = require 'fs'
co = require 'co'
thunkify = require 'thunkify'
yaml = require 'js-yaml'
mkpath = require 'mkpath'
util = require '../util'

assignWithPath = (obj, path, value) ->
  if path.length == 1
    obj[path[0]] = value
  else
    child = obj[path[0]] = {}
    assignWithPath(child, path.slice(1), value)

class YamlDumper
  constructor: (@baseDir, @file) ->

  dump: -> co =>
    translations = yield @file.getTranslations()
    trees = {}

    for translation in translations
      for text in yield translation.getTexts()
        lang = yield text.getLanguage()
        tree = (trees[lang.name] ?= {})
        assignWithPath tree, translation.path.split('.'), text.value

    for lang, tree of trees
      filePath = path.join(@baseDir, "#{@file.path}.#{lang}.yml")
      treeWithLang = {}
      treeWithLang[lang] = tree
      yield util.dumpYAMLFile(treeWithLang, filePath)

    undefined

module.exports = YamlDumper
