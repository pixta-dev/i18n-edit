'use strict'
path = require 'path'
co = require 'co'
_ = require 'lodash'
util = require '../util'
languages = require '../languages'

TranslationVM = require '../view-models/translation-vm'
MapVM = require '../view-models/map-vm'
ArrayVM = require '../view-models/array-vm'

dumpYAMLFromVM = (lang, vm) ->
  dump = (vm) ->
    switch vm.constructor
      when ArrayVM
        vm.children().map dump
      when MapVM
        _.mapValues vm.childrenObject(), dump
      when TranslationVM
        vm.texts()[lang]
  dump vm

dumpYAMLFiles = (baseDir, fileVM) -> co ->
  langs = languages.all()
  for lang in langs
    yaml = dumpYAMLFromVM lang, fileVM.root()
    yamlWithLang = {}
    yamlWithLang[lang] = yaml

    filePath = path.join(baseDir, "#{fileVM.path()}.#{lang}.yml")
    yield util.dumpYAMLFile(yamlWithLang, filePath)

module.exports = dumpYAMLFiles
