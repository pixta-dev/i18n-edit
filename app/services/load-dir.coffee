path = require 'path'
co = require 'co'
thunkify = require 'thunkify'
_ = require 'lodash'
glob = thunkify(require 'glob')

loadYAML = require './load-yaml-files'

module.exports =
loadDir = (dir) -> co ->
  try
    paths = yield glob path.join(dir, '/**/*.yml')

    allFiles = for filePath in paths
      basename = path.basename filePath
      dir = path.dirname filePath

      tokens = basename.split('.')
      name = tokens.slice(0, -2).join()
      {name, dir, filePath}

    fileVMs = []

    for dir, filesByDir of _.groupBy(allFiles, ({dir}) -> dir)
      for name, files of _.groupBy(filesByDir, ({name}) -> name)
        fileVMs.push yield loadYAML dir, name, files.map ({filePath}) -> filePath

    fileVMs

  catch error
    window.alert "フォルダのロードに失敗しました: #{error}"
    []
