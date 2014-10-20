'use strict'

module.exports =
  names: []
  add: (name) ->
    if @names.indexOf(name) < 0
      @names.push(name)
