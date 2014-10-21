'use strict'

app = (require '../app').instance
SearchVM = require './search-vm'

module.exports =
class SideBarVM

  constructor: ->
    @searchKey = ''
    @searchValue = ''
    @folder = ''

  search: ->
    searchVM = new SearchVM(@searchKey, @searchValue)
    app.windowVM.pushState -> searchVM, searchVM.title

  changeFolder: ->
    app.setRootFolder(@folder)
