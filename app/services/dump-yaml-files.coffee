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
    switch vm.constructor
      when ArrayVM
        vm.children.map dump
      when MapVM
        _.mapValues vm.children, dump
      when TranslationVM
        vm.texts[lang]
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
