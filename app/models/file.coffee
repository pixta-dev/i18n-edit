'use strict'

Sequelize = require 'sequelize'
sequelize = require '../db/sequelize'

File = sequelize.define 'File',
  path: Sequelize.STRING

module.exports = File;

Translation = require './translation'
File.hasMany Translation
