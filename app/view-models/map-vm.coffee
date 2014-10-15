'use strict'

ko = require 'knockout'
_ = require 'lodash'

class MapVM

  constructor: (childrenObj) ->
    @childrenObject = ko.observable(childrenObj)
    @children = ko.computed =>
      _.pairs @childrenObject

module.exports = MapVM
