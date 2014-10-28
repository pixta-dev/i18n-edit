'use strict'

h = require 'virtual-dom/h'
languageVM = require '../view-models/language-vm'
app = require '../app'

renderKey = (key, item, depth) ->
  textStyle =
    paddingLeft: "#{depth + 1}em"

  switch item.type
    when 'array', 'map'
      icon = if item.open then 'chevron-bottom' else 'chevron-right'
      h 'td', [
        h 'span.oi.toggle-open-button.tree-table__directory', dataset: {glyph: icon}
        h 'a.tree-table__directory', onclick: (-> item.toggleOpen()), style: textStyle, key
      ]
    when 'translation'
      h 'td', [
        h 'div.toggle-open-button'
        h 'a', onclick: (-> app.windowVM.pushState item), style: textStyle, key
      ]
    else
      h 'td', [
        h 'div.toggle-open-button'
        h 'span.tree-table__directory', style: textStyle, key
      ]

renderValues = (item, file) ->
  switch item.type
    when 'translation'
      languageVM.names.map (name) ->
        h 'td', [
          h 'textarea', onchange: (-> item.setText(name, @value)), item.texts[name]
        ]
    when 'inconsistency'
      languageVM.names.map (name) ->
        h 'td', '構造が矛盾しています'
    else
      languageVM.names.map (name) ->
        h 'td'

renderTree = (key, item, file, depth = 0) ->
  row = h 'tr', [
    renderKey key, item, depth
    renderValues(item, file)...
  ]
  subtrees =
    if item.open
      switch item.type
        when 'array'
          renderTree index.toString(), child, file, depth + 1 for child, index in item.children
        when 'map'
          renderTree childKey, child, file, depth + 1 for childKey, child of item.children
  subtrees ?= []
  [].concat([row], subtrees...)

module.exports = renderTree
