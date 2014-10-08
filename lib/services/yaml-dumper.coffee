'use strict'
path = require 'path'
fs = require 'fs'
co = require 'co'
thunkify = require 'thunkify'
yaml = require 'js-yaml'
mkpath = require 'mkpath'
util = require '../util'

assignWithPath = (obj, path, value, index) ->
  key = path[0]
  if path.length == 1
    if index?
      current = obj[key]
      switch
        when !current?
          obj[key] = [value]
        when Array.isArray current
          current.push value
        else
          obj[key] = [current, value]
    else
      obj[key] = value
  else
    child = obj[key] ?= {}
    assignWithPath(child, path.slice(1), value, index)

class YamlDumper
  constructor: (@baseDir, @file) ->

  dump: -> co =>
    translations = yield @file.getTranslations()
    trees = {}

    for translation in translations
      for text in yield translation.getTexts()
        lang = yield text.getLanguage()
        tree = (trees[lang.name] ?= {})
        assignWithPath tree, translation.path.split('.'), text.value, translation.index

    for lang, tree of trees
      filePath = path.join(@baseDir, "#{@file.path}.#{lang}.yml")
      treeWithLang = {}
      treeWithLang[lang] = tree
      yield util.dumpYAMLFile(treeWithLang, filePath)

    undefined

module.exports = YamlDumper
