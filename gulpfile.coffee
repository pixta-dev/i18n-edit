'use strict'

gulp = require 'gulp'
less = require 'gulp-less'
plumber = require 'gulp-plumber'
notify = require 'gulp-notify'
sourcemaps = require 'gulp-sourcemaps'

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
