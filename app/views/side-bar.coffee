'use strict'

h = require 'virtual-dom/h'

module.exports =
renderSideBar = (sideBarVM) ->
  h 'aside', [
    h 'section', [
      h 'a', onclick: (-> sideBarVM.showAllFiles()), ['ファイル一覧']
    ]
    h 'hr'
    h 'section', [
      h 'label', ['キー']
      h 'input', value: sideBarVM.searchKey, onchange: (-> sideBarVM.searchKey = @value), ['']
      h 'label', ['値']
      h 'input', value: sideBarVM.searchValue, onchange: (-> sideBarVM.searchValue = @value), ['']
      h 'button', onclick: (-> sideBarVM.search()), ['検索']
    ]
    h 'section', [
      h 'label', ['フォルダ']
      h 'p', [sideBarVM.folder]
      h 'button', onclick: (-> sideBarVM.changeFolder()), ['変更']
    ]
  ]
