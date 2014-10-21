'use strict'

module.exports =
class FileTreeVM

  constructor: (baseDir, @files) ->
    @items = @files.map (file) =>
      path = path.relative(baseDir, file.path)
      {file, relativePath}
