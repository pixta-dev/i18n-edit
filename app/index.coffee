'use strict'

global.document = window.document
global.navigator = window.navigator
gui = global.window.nwDispatcher.requireNwGui()

diff = require 'virtual-dom/diff'
patch = require 'virtual-dom/patch'
createElement = require 'virtual-dom/create-element'
app = require './app'

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
