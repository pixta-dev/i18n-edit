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
      @reloadAll()

    dialog.click()

  reloadAll: ->
    app.setRootFolder(@folder)

  showAllFiles: ->
    app.windowVM.pushState new FileTreeVM(app.folder, app.files), 'ファイル一覧'

  toggleOpen: ->
    @open = !@open
    app.update()
