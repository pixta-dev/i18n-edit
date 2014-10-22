'use strict'
path = require 'path'
co = require 'co'
_ = require 'lodash'
util = require '../util'

languageVM = require '../view-models/language-vm'
TranslationVM = require '../view-models/translation-vm'
MapVM = require '../view-models/map-vm'
ArrayVM = require '../view-models/array-vm'

dumpYAMLFromVM = (lang, vm) ->
  dump = (vm) ->
    switch vm.type
      when 'array'
        vm.children.map dump
      when 'map'
        _.mapValues vm.children, dump
      when 'translation'
        vm.texts[lang]
      when 'inconsistency'
        dump vm.trees[lang]
  dump vm

dumpYAMLFiles = (dir, name, fileVM) -> co ->
  langs = languageVM.names
  for lang in langs
    yaml = dumpYAMLFromVM lang, fileVM.root
    yamlWithLang = {}
    yamlWithLang[lang] = yaml

    fileName = if name? && name.length >= 1
      "#{name}.#{lang}.yml"
    else
      "#{lang}.yml"
    filePath = path.join(dir, fileName)
    yield util.dumpYAMLFile(yamlWithLang, filePath)

module.exports = dumpYAMLFiles
