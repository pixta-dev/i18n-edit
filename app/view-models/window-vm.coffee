'use strict'

app = require '../app'
SideBarVM = require './side-bar-vm'

module.exports =
class WindowVM
  constructor: ->
    @sideBar = new SideBarVM()

    Object.defineProperty this, 'prevState',
      get: => @states[@states.length - 2]
    Object.defineProperty this, 'currentState',
      get: => @states[@states.length - 1]
    Object.defineProperty this, 'title',
      get: => @currentState.title

    @clearStates()

  pushState: (vm, title) ->
    @states.push {vm, title}
    @contentVM = vm
    app.update()

  popState: ->
    if @states.length >= 2
      @states.pop()
    app.update()

  clearStates: ->
    @states = []
    @pushState {}, 'ホーム'
