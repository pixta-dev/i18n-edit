'use strict'

gulp = require 'gulp'
gutil = require 'gulp-util'
less = require 'gulp-less'
plumber = require 'gulp-plumber'
notify = require 'gulp-notify'
sourcemaps = require 'gulp-sourcemaps'
NwBuilder = require 'node-webkit-builder'

lessPath = './app/styles/**/*.less'
lessDest = './dist/styles'

gulp.task 'build:less', ->
  gulp.src lessPath
    .pipe plumber
      errorHandler: notify.onError("Error: <%= error.message %>")
    .pipe sourcemaps.init()
    .pipe less()
    .pipe sourcemaps.write()
    .pipe notify("Less Build Finished")
    .pipe gulp.dest lessDest

gulp.task 'watch:less', ->
  gulp.watch lessPath, ['build:less']

gulp.task 'default', ['build:less', 'watch:less']

deployPackages = Object.keys((require './package.json').dependencies)
deployFiles = [
  './package.json'
  './index.html'
  './app/**/*'
  './dist/**/*'
  (deployPackages.map (pack) -> "./node_modules/#{pack}/**/*")...
  './bower_components/normalize.css/normalize.css'
  './bower_components/open-iconic/font/css/open-iconic.min.css'
  './bower_components/open-iconic/font/fonts/**/*'
]

gulp.task 'package', ->
  nw = new NwBuilder
    files: deployFiles
    platforms: ['win64', 'osx64']

  nw.on 'log', (msg) ->
    gutil.log(msg)

  nw.build()
