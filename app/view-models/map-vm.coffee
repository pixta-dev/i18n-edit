'use strict'

ko = require 'knockout'
_ = require 'lodash'
KeyValueVM = require './key-value-vm'

module.exports =
class MapVM

  constructor: (childrenObj) ->
    @type = 'map'
    @childrenObject = ko.observable(childrenObj)
    @children = ko.computed =>
      _.pairs(@childrenObject()).map ([k, v]) =>
        new KeyValueVM k, v
