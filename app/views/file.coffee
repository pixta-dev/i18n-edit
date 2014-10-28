'use strict'

h = require 'virtual-dom/h'
renderTree = require './tree'
languageVM = require '../view-models/language-vm'

module.exports = (fileVM) ->
  h 'section', [
    h 'table.tree-table', [
      h 'thead', [
        h 'tr', [
          h 'th', ['キー']
          (h 'th', name for name in languageVM.names)...
        ]
      ]
      renderTree('[ファイル]', fileVM.root, fileVM)...
    ]
  ]
