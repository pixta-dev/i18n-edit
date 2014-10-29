'use strict'

h = require 'virtual-dom/h'
app = require '../app'

module.exports =
renderDialog = (dialog) ->
  h '.dialog-back', [
    h '.dialog', [
      h 'h4', dialog.title
      h 'input', onchange: (-> dialog.value = @value), value: dialog.value
      h 'div', [
        h 'button.button', onclick: (-> dialog.complete(dialog.value)), 'OK'
        h 'button.button', onclick: (-> app.windowVM.dialog = null; app.update()), 'キャンセル'
      ]
    ]
  ]
