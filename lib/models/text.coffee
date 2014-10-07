'use strict'

Sequelize = require 'sequelize'
sequelize = require '../db/sequelize'

Text = sequelize.define 'Text',
  value: Sequelize.STRING

module.exports = Text

Translation = require './translation'
Language = require './language'
Text.belongsTo Translation
Text.belongsTo Language
