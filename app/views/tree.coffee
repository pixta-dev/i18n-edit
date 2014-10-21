'use strict'

h = require 'virtual-dom/h'
languageVM = require '../view-models/language-vm'

renderKey = (key, item, depth) ->
  span = h 'span', { style: { paddingLeft: "#{depth + 1}em" }}, [key]

  if item.type == 'translation'
    h 'td', [
      h 'div', { style: { width: '0.5em', height: '0.5em' } }, ['']
      span
    ]
  else
    icon = if item.open
      './bower_components/open-iconic/svg/chevron-bottom.svg'
    else
      './bower_components/open-iconic/svg/chevron-right.svg'

    h 'td', { onclick: -> item.toggleOpen() }, [
      h 'img', { style: { width: '0.5em', height: '0.5em' }, src: icon }, ['']
      span
    ]

renderValues = (item) ->
  isTranslation = (item.type == 'translation')
  for name in languageVM.names
    if isTranslation
      onchange = ->
        item.texts[name] = @value
      h 'td', [
        h 'textarea', {onchange}, [item.texts[name] || '']
      ]
    else
      h 'td', ['']

renderTree = (key, item, depth = 0) ->
  rowType = if item.type == 'translation'
    'tr'
  else
    'tr.pure-table-odd'

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
