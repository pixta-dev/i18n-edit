'use strict'

h = require 'virtual-dom/h'
_ = require 'lodash'
renderSideBar = require './side-bar'
renderContent = require './content'

renderBack = (windowVM) ->
  h '.back-page', if windowVM.prevState?
      [h 'a', onclick: (-> windowVM.popState()), "‹ #{windowVM.prevState.title}"]
    else
      []

module.exports =
renderWindow = (windowVM) ->
  h '.root', [
    h 'header.header', [
      h 'button.header__menu', onclick: (-> windowVM.sideBar.toggleOpen()), [
        h 'span.oi', dataset: {glyph: 'menu'}
      ]
      h 'h1.header__title', windowVM.title
    ]
    h '.rows', [
      renderSideBar windowVM.sideBar
      h 'article.content', [
        renderBack windowVM
        renderContent windowVM.currentState.vm
      ]
    ]
  ]
