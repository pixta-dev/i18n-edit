'use strict'

app = (require '../app').instance
SideBarVM = require './sidebar-vm'

module.exports =
class WindowVM
  constructor: ->
    @title = 'Title'
    @sideBar = new SideBarVM()
    @sideBarOpen = true
    @states = []

  pushState: (vmLazy, title) ->
    @states.push {vmLazy, title}
    @contentVM = vmLazy()
    app.update()

  clearStates: ->
    @states = []
