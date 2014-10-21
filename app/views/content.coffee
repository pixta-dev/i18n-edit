'use strict'

h = require 'virtual-dom/h'
renderFile = require './file'
renderFileTree = require './file-tree'
renderTranslation = require './translation'
renderSearch = require './search'

module.exports =
renderContent = (contentVM) ->
  switch contentVM.type
    when 'file'
      renderFile contentVM
    when 'fileTree'
      renderFileTree contentVM
    when 'translation'
      renderTranslation contentVM
    when 'search'
      renderSearch contentVM
