'use strict'

Sequelize = require 'sequelize'
sequelize = new Sequelize 'db', '', '',
  dialect: 'sqlite'
  logging: false

module.exports = sequelize
