'use strict'

gui = if global.window?
  global.window.nwDispatcher.requireNwGui()
else
  console.warn 'window not found'

module.exports = gui
