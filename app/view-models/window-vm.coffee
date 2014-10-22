'use strict'

app = require '../app'
SideBarVM = require './side-bar-vm'
computed = (require '../util').computedProperty

module.exports =
class WindowVM
  computed @, 'prevState', -> @states[@states.length - 2]
  computed @, 'currentState', -> @states[@states.length - 1]
  computed @, 'title', -> @currentState.title

  constructor: ->
    @sideBar = new SideBarVM()
    @clearStates()

  pushState: (vm, title) ->
    title ?= vm.title
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
