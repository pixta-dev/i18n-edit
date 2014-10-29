'use strict'

CollapsibleVM = require './collapsible-vm'
TranslationVM = require './translation-vm'
gui = global.window.nwDispatcher.requireNwGui()

module.exports =
class MapVM extends CollapsibleVM
  type: 'map'

  constructor: (@children) ->
    super()
    for own key, child of @children
      child.parent = this

  keyForChild: (child) ->
    for own key, value of @children
      if child == value
        return key
    null

  addKey: (key) ->
    child = new TranslationVM({})
    child.parent = this
    @children[key] = child

  removeKey: (key) ->
    delete @children[key]

  showMenu: (x, y) ->
    console.log 'menu'
    menu = new gui.Menu()
    menu.append new gui.MenuItem
      label: 'hoge'
      click: -> console.log 'hoge'
    menu.popup(x, y)
