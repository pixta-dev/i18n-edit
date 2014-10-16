'use strict'

ko = require 'knockout'

module.exports =
class FileVM

  constructor: (path, root) ->
    @path = ko.observable(path)
    @root = ko.observable(root)
