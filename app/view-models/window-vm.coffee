'use strict'

app = require '../app'
SideBarVM = require './side-bar-vm'

module.exports =
class WindowVM
  constructor: ->
    @sideBar = new SideBarVM()
    @states = []

    Object.defineProperty this, 'prevState',
      get: => @states[@states.length - 2]
    Object.defineProperty this, 'currentState',
      get: => @states[@states.length - 1]
    Object.defineProperty this, 'title',
      get: => @currentState.title

    @pushState {}, 'Home'

  pushState: (vm, title) ->
    @states.push {vm, title}
    @contentVM = vm
    app.update()

  clearStates: ->
    @states = []
