'use strict'

fs = require 'fs'
co = require 'co'
thunkify = require 'thunkify'
yaml = require 'js-yaml'
mkpath = require 'mkpath'
path = require 'path'

module.exports =
  loadYAMLFile: (filePath) -> co ->
    data = yield thunkify(fs.readFile) filePath, encoding: 'utf-8'
    yaml.safeLoad data

  dumpYAMLFile: (obj, filePath) -> co ->
    data = yaml.safeDump(obj)
    mkpath path.dirname(filePath)
    yield thunkify(fs.writeFile) filePath, data
