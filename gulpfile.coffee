'use strict'

gulp = require 'gulp'
gutil = require 'gulp-util'
less = require 'gulp-less'
plumber = require 'gulp-plumber'
notify = require 'gulp-notify'
sourcemaps = require 'gulp-sourcemaps'
zip = require 'gulp-zip'
es = require 'event-stream'
NwBuilder = require 'node-webkit-builder'

packageJson = require './package.json'

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

gulp.task 'build', ['build:less']
gulp.task 'watch', ['watch:less']

gulp.task 'default', ['build', 'watch']

deployFiles = [
  './package.json'
  './LICENSE'
  './index.html'
  './app/**/*'
  './dist/**/*'
  (Object.keys(packageJson.dependencies).map (pack) -> "./node_modules/#{pack}/**/*")...
  './bower_components/normalize.css/normalize.css'
  './bower_components/open-iconic/font/css/open-iconic.min.css'
  './bower_components/open-iconic/font/fonts/**/*'
]
deployPlatforms = ['win32', 'osx64']

gulp.task 'deploy', ['build'], ->
  nw = new NwBuilder
    files: deployFiles
    platforms: deployPlatforms

  nw.on 'log', (msg) ->
    gutil.log(msg)

  nw.build()

gulp.task 'archive', ['deploy'], ->
  tasks = deployPlatforms.map (platform) ->
    gulp.src("./build/i18n-edit/#{platform}/**/*")
      .pipe zip("i18n-edit_#{platform}.zip")
      .pipe gulp.dest("./build/archives")
  es.merge tasks...
