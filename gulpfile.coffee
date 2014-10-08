'use strict'

gulp = require 'gulp'
jade = require 'gulp-jade'
plumber = require 'gulp-plumber'
notify = require 'gulp-notify'

jadePath = './app/views/**/*.jade'

gulp.task 'build:jade', ->
  gulp.src jadePath
    .pipe plumber
      errorHandler: notify.onError("Error: <%= error.message %>")
    .pipe jade()
    .pipe notify("Build Finished")
    .pipe gulp.dest './dist/views'

gulp.task 'watch:jade', ->
  gulp.watch jadePath, ['build:jade']

gulp.task 'default', ['build:jade', 'watch:jade']
