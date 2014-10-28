'use strict'

h = require 'virtual-dom/h'
app = require '../app'

module.exports =
renderSearch = (searchVM) ->
  h 'section', [
    h 'table', [
      h 'thead', [
        h 'th', 'キー'
        h 'th', '値'
        h 'th', '言語'
        h 'th', 'ファイル'
      ]
      (searchVM.results.map (result) ->
        debugger
        h 'tr', [
          h 'td', [
            h 'a', onclick: (-> app.windowVM.pushState result.translation), result.fullKey
          ]
          h 'td', result.text
          h 'td', result.language
          h 'td', [
            h 'a', onclick: (-> app.windowVM.pushState result.file), result.file.title
          ]
        ]
      )...
    ]
  ]
