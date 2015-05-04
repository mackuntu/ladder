gulp = require 'gulp'

coffee  = require 'gulp-coffee'
concat  = require 'gulp-concat'
gutil   = require 'gulp-util'
watch   = require 'gulp-watch'
batch   = require 'gulp-batch'

gulp.task 'build', ->
  gulp.src 'app/js/**/*.coffee'
  .pipe coffee bare: true
  .pipe concat 'app.js'
  .pipe gulp.dest 'dist'
  .on 'error', gutil.log

gulp.task 'watch', ->
  gulp.start 'build'
  watch 'app/js/**/*.coffee', batch ->
    gulp.start 'build'
