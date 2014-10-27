'use strict'

h = require 'virtual-dom/h'
languageVM = require '../view-models/language-vm'
app = require '../app'

renderKey = (key, item, depth) ->
  span = h 'span', { style: { paddingLeft: "#{depth + 1}em" }}, [key]

  switch item.type
    when 'array', 'map'
      icon = "./bower_components/open-iconic/svg/chevron-#{if item.open then 'bottom' else 'right'}.svg"

      h 'td', { onclick: -> item.toggleOpen() }, [
        h 'img', { style: { width: '0.5em', height: '0.5em' }, src: icon }, ['']
        span
      ]
    when 'translation'
      h 'td', { onclick: -> app.windowVM.pushState item }, [
        h 'div', { style: { width: '0.5em', height: '0.5em' } }, ['']
        span
      ]
    else
      h 'td', [
        h 'div', { style: { width: '0.5em', height: '0.5em' } }, ['']
        span
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
