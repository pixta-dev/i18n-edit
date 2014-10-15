'use strict'

co = require 'co'
yaml = require 'js-yaml'
_ = require 'lodash'

util = require '../util'
languages = require '../languages'

TranslationVM = require '../view-models/translation-vm'
MapVM = require '../view-models/map-vm'
ArrayVM = require '../view-models/array-vm'
FileVM = require '../view-models/file-vm'

langBeforeLeaf = (lang, yaml) ->
  switch
    when _.isPlainObject yaml
      _.mapValues yaml, (child) -> langBeforeLeaf lang, child
    when _.isArray yaml
      yaml.map (child) -> langBeforeLeaf lang, child
    else
      obj = { _isLang: true, texts: {} }
      obj.texts[lang] = yaml
      obj

treeToVM = (tree) ->
  switch
    when tree._isLang
      new TranslationVM tree.texts
    when _.isArray tree
      new ArrayVM tree.map treeToVM
    when _.isPlainObject tree
      new MapVM _.mapValues tree, treeToVM

loadYAMLFiles = (path, files) -> co ->
  tree = {}
  for file in files
    yaml = yield util.loadYAMLFile(file)
    for lang, child of yaml
      languages.add lang
      _.merge tree, langBeforeLeaf lang, child
  root = treeToVM tree
  new FileVM(path, root)

module.exports = loadYAMLFiles
