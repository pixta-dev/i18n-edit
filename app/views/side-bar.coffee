'use strict'

h = require 'virtual-dom/h'
_ = require 'lodash'

visibleIf = (cond, node) ->
  unless cond
    node.properties = _.merge({}, node.properties, {style: {display: 'none'}})
  node

module.exports =
renderSideBar = (sideBarVM) ->
  visibleIf sideBarVM.open, h 'aside', [
    h 'section', [
      h 'a', onclick: (-> sideBarVM.showAllFiles()), 'ファイル一覧'
    ]
    h 'hr'
    h 'section', [
      h 'label', 'キー'
      h 'input', value: sideBarVM.searchKey, onchange: (-> sideBarVM.searchKey = @value)
      h 'label', '値'
      h 'input', value: sideBarVM.searchValue, onchange: (-> sideBarVM.searchValue = @value)
      h 'button', onclick: (-> sideBarVM.search()), '検索'
    ]
    h 'section', [
      h 'label', 'フォルダ'
      h 'p', sideBarVM.folder
      h 'button', onclick: (-> sideBarVM.selectFolder()), '変更'
      visibleIf sideBarVM.folder != '', h 'button', onclick: (-> sideBarVM.reloadAll()), '全リロード'
    ]
  ]
