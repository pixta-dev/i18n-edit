'use strict'

h = require 'virtual-dom/h'
kup = require 'vtree-kup'
app = require '../app'

renderFiles = (items) -> kup (k) ->
  k.ul ->
    items.forEach (item) ->
      k.li ->
        k.a onclick: (-> app.windowVM.pushState item.file), item.file.title

module.exports =
renderFileTree = (fileTreeVM) -> kup (k) ->
  k.section ->
    k.$add renderFiles(fileTreeVM.items)
