'use strict'

app = require '../app'
SearchVM = require './search-vm'
FileTreeVM = require './file-tree-vm'

module.exports =
class SideBarVM

  constructor: ->
    @open = true
    @searchKey = ''
    @searchValue = ''
    @folder = ''

  search: ->
    app.windowVM.pushState new SearchVM(@searchKey, @searchValue)

  selectFolder: ->
    dialog = document.createElement('input')
    dialog.type = 'file'
    dialog.setAttribute('nwdirectory', '')
    dialog.onchange = =>
      @folder = dialog.value
      #app.setRootFolder(@folder)
      app.update()

    dialog.click()

  showAllFiles: ->
    app.windowVM.pushState new FileTreeVM(app.files)

  toggleOpen: ->
    @open = !@open
    app.update()
