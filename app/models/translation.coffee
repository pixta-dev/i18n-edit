'use strict'

Sequelize = require 'sequelize'
sequelize = require '../db/sequelize'

Translation = sequelize.define 'Translation',
  path: Sequelize.STRING
  index: Sequelize.INTEGER

module.exports = Translation

Text = require './text'
File = require './file'
Lauguage = require './language'

Translation.belongsTo File
Translation.hasMany Text
