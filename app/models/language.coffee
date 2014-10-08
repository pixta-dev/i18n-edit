'use strict'

Sequelize = require 'sequelize'
sequelize = require '../db/sequelize'

Language = sequelize.define 'Language',
  name: Sequelize.STRING

module.exports = Language;

Text = require './text'
Language.hasMany Text
