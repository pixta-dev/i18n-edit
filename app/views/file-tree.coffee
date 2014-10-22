'use strict'

h = require 'virtual-dom/h'
app = require '../app'

renderFiles = (items) ->
  items.map (item) ->
    h 'li', [
      h 'a', onclick: (-> app.windowVM.pushState item.file), item.relativePath
    ]

module.exports =
renderFileTree = (fileTreeVM) ->
  h 'section', [
    renderFiles(fileTreeVM.items)...
  ]
