'use strict'

h = require 'virtual-dom/h'
_ = require 'lodash'
renderSideBar = require './side-bar'
renderContent = require './content'

renderBack = (windowVM) ->
  if windowVM.prevState?
    [h 'a', onclick: (-> windowVM.popState()), "‹ #{windowVM.prevState.title}"]
  else
    []

module.exports =
renderWindow = (windowVM) ->
  h 'section', [
    h 'header', [
      h 'a', onclick: (-> windowVM.sideBar.toggleOpen()), 'Menu'
      h 'h1', windowVM.title
    ]
    renderSideBar windowVM.sideBar
    (renderBack windowVM)...
    renderContent windowVM.currentState.vm
  ]
