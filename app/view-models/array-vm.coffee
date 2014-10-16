'use strict'

ko = require 'knockout'
KeyValueVM = require './key-value-vm'

module.exports =
class ArrayVM

  constructor: (children) ->
    @type = 'array'
    @childrenArray = ko.observable(children)
    @children = ko.computed =>
      for child, i in @childrenArray()
        new KeyValueVM i, child

  indexForChild: (child) ->
    @children().indexOf(child)
