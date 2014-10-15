'use strict'

ko = require 'knockout'

class ArrayVM

  constructor: (children) ->
    @children = ko.observableArray(children)

module.exports = ArrayVM
