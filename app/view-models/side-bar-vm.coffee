'use strict'

app = require '../app'
SearchVM = require './search-vm'
FileTreeVM = require './file-tree-vm'

module.exports =
class SideBarVM

  Object.defineProperty @::, 'folder',
    get: -> app.folder

  constructor: ->
    @open = true
    @searchKey = ''
    @searchValue = ''

  search: ->
    app.windowVM.pushState new SearchVM(@searchKey, @searchValue)

  selectFolder: ->
    dialog = document.createElement('input')
    dialog.type = 'file'
    dialog.setAttribute('nwdirectory', '')
    dialog.onchange = =>
      app.setRootFolder dialog.value

    dialog.click()

  reloadAll: ->
    app.reloadAll()

  showAllFiles: ->
    app.windowVM.pushState new FileTreeVM(app.folder, app.files), 'ファイル一覧'

  toggleOpen: ->
    @open = !@open
    app.update()
