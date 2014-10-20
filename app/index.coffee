'use strict'

global.document = window.document
global.navigator = window.navigator
gui = global.window.nwDispatcher.requireNwGui()

$ = require 'jquery'
diff = require 'virtual-dom/diff'
patch = require 'virtual-dom/patch'
createElement = require 'virtual-dom/create-element'
App = require './app'

App.start()

$ ->

  rootDOM = null
  tree = null

  App.instance.on 'update', ->

    newTree = App.instance.render()
    if rootDOM?
      patches = diff(tree, newTree)
      rootDOM = patch(rootDOM, patches)
    else
      rootDOM = createElement(newTree)
      $('body').append(rootDOM)
    tree = newTree
