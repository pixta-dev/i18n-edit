'use strict'

h = require 'virtual-dom/h'
kup = require 'vtree-kup'
app = require '../app'
languageVM = require '../view-models/language-vm'

module.exports =
renderTranslation = (translationVM) -> kup (k) ->
  k.section ->
    k.dl '.translation-description', ->
      k.dt 'パス'
      k.dd translationVM.path
      k.dt 'ファイル'
      k.dd ->
        k.a onclick: (-> app.windowVM.pushState translationVM.file), translationVM.file.title

    k.table ->
      k.thead ->
        k.th '言語'
        k.th '値'

      languageVM.names.forEach (lang) ->
        text = translationVM.texts[lang]
        k.tr ->
          k.td lang
          k.td ->
            k.textarea onchange: (-> translationVM.setText(lang, @value)), text
