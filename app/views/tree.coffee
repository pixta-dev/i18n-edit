'use strict'

h = require 'virtual-dom/h'
languageVM = require '../view-models/language-vm'

renderKey = (key, item, depth) ->
  attrs = {}
  unless item.type == 'translation'
    attrs.onclick = -> item.toggleOpen()
  h 'td', attrs, [
    h 'span', { style: { paddingLeft: "#{depth * 20}px" }}, [key]
  ]

renderValues = (item) ->
  isTranslation = (item.type == 'translation')
  for name in languageVM.names
    if isTranslation
      h 'td', [item.texts[name] || '']
    else
      h 'td', ['']

renderTree = (key, item, depth = 0) ->
  row = h 'tr', [
    renderKey key, item, depth
    renderValues(item)...
  ]
  subtrees =
    if item.open
      switch item.type
        when 'array'
          renderTree index.toString(), child, depth + 1 for child, index in item.children
        when 'map'
          renderTree childKey, child, depth + 1 for childKey, child of item.children
  subtrees ?= []
  [].concat([row], subtrees...)

module.exports = renderTree
