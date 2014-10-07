'use strict'

Sequelize = require 'sequelize'
sequelize = new Sequelize 'db', '', '', dialect: 'sqlite'

module.exports = sequelize
