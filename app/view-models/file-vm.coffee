'use strict'

ko = require 'knockout'
languageVM = require './language-vm'

module.exports =
class FileVM

  constructor: (path, root) ->
    @path = ko.observable(path)
    @root = ko.observable(root)
    @languageVM = languageVM
