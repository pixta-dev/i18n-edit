'use strict'

fs = require 'fs'
co = require 'co'
thunkify = require 'thunkify'
yaml = require 'js-yaml'
mkpath = require 'mkpath'
path = require 'path'

assignWithPath = (obj, keys, index, value) ->
  key = keys[0]
  if keys.length == 1
    if index?
      current = obj[key]
      switch
        when !current?
          obj[key] = [value]
        when Array.isArray current
          current.push value
        else
          obj[key] = [current, value]
    else
      obj[key] = value
  else
    child = obj[key] ?= {}
    assignWithPath(child, keys.slice(1), index, value)

module.exports =
  loadYAMLFile: (filePath) -> co ->
    data = yield thunkify(fs.readFile) filePath, encoding: 'utf-8'
    yaml.safeLoad data

  dumpYAMLFile: (obj, filePath) -> co ->
    data = yaml.safeDump(obj)
    mkpath path.dirname(filePath)
    yield thunkify(fs.writeFile) filePath, data

  assignToTranslationTree: (obj, path, index, value) ->
    assignWithPath(obj, path.split('.'), index, value)
