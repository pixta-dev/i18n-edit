'use strict'

ko = require 'knockout'

module.exports =
class KeyValueVM

  constructor: (@key, @value) ->
    @type = 'mapEntry'
