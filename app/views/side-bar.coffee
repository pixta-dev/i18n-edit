'use strict'

h = require 'virtual-dom/h'
_ = require 'lodash'

visibleIf = (cond, node) ->
  unless cond
    node.properties = _.merge({}, node.properties, {style: {display: 'none'}})
  node

module.exports =
renderSideBar = (sideBarVM) ->
  visibleIf sideBarVM.open, h 'aside.side-bar', [
    h '.side-bar__frame', [
      h '.side-bar__content', [
        h 'section.side-bar__section', [
          h 'a.side-bar__link', onclick: (-> sideBarVM.showAllFiles()), 'ファイル一覧'
        ]
        h 'hr.horizontal-line'
        h 'section.side-bar__section', [
          h 'div.form-line', [
            h 'label', for: 'searchKey', 'キー'
            h 'input', name: 'searchKey', value: sideBarVM.searchKey, onchange: (-> sideBarVM.searchKey = @value)
          ]
          h 'div.form-line', [
            h 'label', for: 'searchValue', '値'
            h 'input', name: 'searchValue', value: sideBarVM.searchValue, onchange: (-> sideBarVM.searchValue = @value)
          ]
          h 'input.button', type: 'submit', onclick: (-> sideBarVM.search()), value: '検索'
        ]
        h 'section.side-bar__section', [
          h 'label', 'フォルダ'
          h 'p.folder-view', sideBarVM.folder
          h 'button.button', onclick: (-> sideBarVM.selectFolder()), '変更'
          visibleIf sideBarVM.folder != '', h 'button.button', onclick: (-> sideBarVM.reloadAll()), '全リロード'
        ]
      ]
    ]
  ]
