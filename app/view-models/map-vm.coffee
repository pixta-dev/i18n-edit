'use strict'

app = require '../app'
CollapsibleVM = require './collapsible-vm'
TranslationVM = require './translation-vm'
gui = require '../gui'

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
    @file.saveAll()

  removeKey: (key) ->
    delete @children[key]

  createMenuItems: ->
    createMenu = (label, type) =>
      new gui.MenuItem
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
    [
      super()...
      createMenu 'グループ追加', 'map'
      createMenu 'キー追加', 'translation'
    ]
