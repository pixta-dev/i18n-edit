'use strict'

h = require 'virtual-dom/h'
app = require '../app'

module.exports =
renderTranslation = (translationVM) ->
  h 'section', [
    h 'dl', [
      h 'dt', 'パス'
      h 'dd', translationVM.path
      h 'dt', 'ファイル'
      h 'dd', [
        h 'a', onclick: (-> app.windowVM.pushState translationVM.file), translationVM.file.title
      ]
    ]
    h 'table', [
      h 'thead', [
        h 'th', '言語'
        h 'th', '値'
      ]
      (Object.keys(translationVM.texts).map (lang) ->
        text = translationVM.texts[lang]
        h 'tr', [
          h 'td', lang
          h 'td', [
            h 'textarea', onchange: (-> translationVM.setText(lang, @value)), text
          ]
        ]
      )...
    ]
  ]
