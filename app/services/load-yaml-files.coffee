'use strict'

co = require 'co'
yaml = require 'js-yaml'
_ = require 'lodash'

util = require '../util'

mergeTree = (a, b, langsA, langsB) ->
  switch
    when !a?
      b

    when !b?
      a

    when a.type == b.type == 'array'
      children = _.zip(a.children, b.children).map ([x, y]) -> mergeTree x, y, langsA, langsB
      new ArrayVM children

    when a.type == b.type == 'map'
      children = {}
      keys = _.union Object.keys(a.children), Object.keys(b.children)
      for key in keys
        children[key] = mergeTree a.children[key], b.children[key], langsA, langsB
      new MapVM children

    when a.type == b.type == 'translation'
      new TranslationVM _.merge({}, a.texts, b.texts)

    when a.type == b.type == 'inconsistency'
      new InconsistencyVM _.merge({}, a.trees, b.trees)

    when a.type == 'inconsistency'
      trees = _.merge {}, a.trees
      for lang in langB
        trees[lang] = b
      new InconsistencyVM trees

    when b.type == 'inconsistency'
      mergeTree b, a, langsB, langsA

    else
      trees = {}
      for lang in langsA
        trees[lang] = a
      for lang in langsB
        trees[lang] = b
      new InconsistencyVM trees

yamlToVM = (yaml, lang) ->
  toVM = (yaml) ->
    switch
      when _.isArray yaml
        new ArrayVM yaml.map toVM
      when _.isPlainObject yaml
        new MapVM _.mapValues yaml, toVM
      else
        texts = {}
        texts[lang] = yaml
        new TranslationVM texts
  toVM yaml

module.exports =
loadYAMLFiles = (dir, name, files) -> co ->
  time = new Date().getTime()

  vms = []
  for file in files
    yaml = yield util.loadYAMLFile(file)
    for lang, child of yaml
      languageVM.add lang
      vm = yamlToVM child, lang
      langs = [lang]
      vms.push [vm, langs]

  [vm, langs] = vms.reduce ([vm1, langs1], [vm2, langs2]) ->
    [mergeTree vm1, vm2, langs1, langs2, _.union langs1, langs2]

  console.log "#{new Date().getTime() - time} ms elapsed"

  new FileVM(dir, name, vm)

languageVM = require '../view-models/language-vm'
TranslationVM = require '../view-models/translation-vm'
MapVM = require '../view-models/map-vm'
ArrayVM = require '../view-models/array-vm'
FileVM = require '../view-models/file-vm'
InconsistencyVM = require '../view-models/inconsistency-vm'
