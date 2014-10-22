'use strict'

path = require 'path'

module.exports =
class FileTreeVM
  type: 'fileTree'

  constructor: (baseDir, @files) ->
    console.log @files
    @items = @files.map (file) =>
      relativePath = path.relative(baseDir, path.join(file.dir, file.name))
      {file, relativePath}
