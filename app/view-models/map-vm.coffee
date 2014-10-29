'use strict'

app = require '../app'
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

  addKey: (key, type) ->
    if @children.hasOwnProperty key
      window.alert('すでに存在するキーです。')
      return

    child = switch type
      when 'translation'
        new TranslationVM({})
      when 'map'
        new MapVM({})
      else
        throw new Error('Unimplemented type')
    child.parent = this
    @children[key] = child
    console.log 'key added'

  removeKey: (key) ->
    delete @children[key]

  showMenu: (x, y) ->
    console.log 'menu'
    menu = new gui.Menu()

    createMenu = (label, type) =>
      menu.append new gui.MenuItem
        label: label
        click: =>
          app.windowVM.dialog =
            title: label
            value: 'key'
            complete: (value) =>
              app.windowVM.dialog = null
              @addKey(value, type)
              app.update()
          app.update()

    createMenu 'グループ追加', 'map'
    createMenu 'キー追加', 'translation'

    menu.popup(x, y)
