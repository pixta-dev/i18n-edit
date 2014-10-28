'use strict'

global.document = window.document
global.navigator = window.navigator
gui = global.window.nwDispatcher.requireNwGui()

diff = require 'virtual-dom/diff'
patch = require 'virtual-dom/patch'
createElement = require 'virtual-dom/create-element'
app = require './app'

window.onerror = (message, url, lineNumber, column, error) ->
  window.alert ("エラーが発生しました: " + error.message + "\n再起動します...")
  # Reload script (see https://groups.google.com/forum/#!topic/node-webkit/KI_ciowScNo)
  gui.Window.get().reload(3)

window.addEventListener 'load', ->
  app.start()

  tree = app.render()
  rootDOM = createElement(tree)
  document.body.appendChild(rootDOM)

  app.on 'update', ->
    newTree = app.render()
    patches = diff(tree, newTree)
    rootDOM = patch(rootDOM, patches)
    tree = newTree
