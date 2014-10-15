'use strict'

ko = require 'knockout'

class FileVM

  constructor: (path, root) ->
    @path = ko.observable(path)
    @root = ko.observable(root)

module.exports = FileVM
