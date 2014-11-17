'use strict'

h = require 'virtual-dom/h'
kup = require 'vtree-kup'
renderTree = require './tree'
languageVM = require '../view-models/language-vm'

module.exports = (fileVM) -> kup (k) ->
  k.section ->

    if fileVM.errors.length > 0
      k.section '.error', ->
        k.h2 'エラー'
        k.ul ->
          for error in fileVM.errors
            k.li error
    else
      k.table '.tree-table', ->
        k.thead ->
          k.tr ->
            k.th 'キー'
            for name in languageVM.names
              k.th name
        k.$add renderTree('[ファイル]', fileVM.root, fileVM)
