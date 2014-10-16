'use strict'

co = require 'co'
yaml = require 'js-yaml'
_ = require 'lodash'

util = require '../util'

languageVM = require '../view-models/language-vm'
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
  time = new Date().getTime()
  for file in files
    yaml = yield util.loadYAMLFile(file)
    for lang, child of yaml
      languageVM.add lang
      _.merge tree, langBeforeLeaf lang, child
  root = treeToVM tree
  console.log "#{new Date().getTime() - time} ms elapsed"
  new FileVM(path, root)

module.exports = loadYAMLFiles
