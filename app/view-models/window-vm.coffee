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
    scroll = [window.scrollX, window.scrollY]
    window.scroll(0, 0)
    @states.push {vm, title, scroll}
    @contentVM = vm
    app.update()

  popState: ->
    if @states.length >= 2
      state = @states.pop()
      window.scroll(state.scroll...)
      app.update()

  clearStates: ->
    @states = []
    @pushState {}, 'ホーム'
