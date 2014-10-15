'use strict'

path = require 'path'

Sequelize = require 'sequelize'
sequelize = new Sequelize 'db', '', '',
  dialect: 'sqlite'
  logging: false
  #storage: path.join __dirname, 'db.sqlite'

module.exports = sequelize
