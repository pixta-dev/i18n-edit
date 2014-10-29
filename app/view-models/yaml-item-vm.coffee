'use strict'

app = require '../app'
util = require '../util'
gui = require '../gui'

module.exports =
class YAMLItemVM

  Object.defineProperty @::, 'path',
    get: ->
      path = if @parent?
        parentPath = @parent.path
        if parentPath == ''
          @key
        else
          "#{parentPath}.#{@key}"
      else
        ''
  Object.defineProperty @::, 'key',
    get: -> @parent?.keyForChild(this)

  Object.defineProperty @::, 'file',
    get: ->
      @_file ? @parent?.file
    set: (@_file) ->

  constructor: ->
    @parent = null

  createMenuItems: ->
    items = []
    if @parent? && @parent.type == 'map'
      items.push new gui.MenuItem
        label: '削除'
        click: =>
          app.windowVM.dialog = null
          @parent.removeKey(@key)
          @file.saveAll()
          app.update()
    items

  showMenu: (x, y) ->
    console.log 'menu'
    menu = new gui.Menu()
    for item in @createMenuItems()
      menu.append item

    menu.popup(x, y)
