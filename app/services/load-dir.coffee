path = require 'path'
co = require 'co'
thunkify = require 'thunkify'
glob = thunkify(require 'glob')
loadYAML = require './load-yaml-files'

loadDir = (dir) -> co ->
  paths = yield glob path.join(dir, '/**/*.yml')

  allFiles = for path in paths
    basename = path.basename path
    dir = path.dirname path

    tokens = basename.split('.')
    name = tokens.slice(0, -2).join()
    {name, dir, path}

  fileVMs = []

  for dir, filesByDir of _.groupBy(allFiles, ({dir}) -> dir)
    for name, files of _.groupBy(filesByDir, ({name}) -> name)
      fileVMs.push yield loadYAML dir, name, files.map ({path}) -> path

  fileVMs

module.exports = loadDir
