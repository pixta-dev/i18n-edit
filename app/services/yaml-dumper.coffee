'use strict'
path = require 'path'
fs = require 'fs'
co = require 'co'
thunkify = require 'thunkify'
yaml = require 'js-yaml'
mkpath = require 'mkpath'
util = require '../util'

class YamlDumper
  constructor: (@baseDir, @file) ->

  dump: -> co =>
    translations = yield @file.getTranslations()
    trees = {}

    for translation in translations
      for text in yield translation.getTexts()
        lang = yield text.getLanguage()
        tree = (trees[lang.name] ?= {})
        util.assignToTranslationTree tree, translation.path, translation.index, text.value

    for lang, tree of trees
      filePath = path.join(@baseDir, "#{@file.path}.#{lang}.yml")
      treeWithLang = {}
      treeWithLang[lang] = tree
      yield util.dumpYAMLFile(treeWithLang, filePath)

    undefined

module.exports = YamlDumper
