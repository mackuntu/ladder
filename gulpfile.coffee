'use strict'
gulp = require 'gulp'

coffee      = require 'gulp-coffee'
jade        = require 'gulp-jade'
concat      = require 'gulp-concat'
gutil       = require 'gulp-util'
batch       = require 'gulp-batch'
coffeelint  = require 'gulp-coffeelint'
browserify  = require 'gulp-browserify'
clean       = require 'gulp-clean'
nodemon     = require 'gulp-nodemon'
browsersync = require 'browser-sync'
reload      = browsersync.reload
gulpFilter  = require 'gulp-filter'
bowerSrc    = require 'gulp-bower-src'
uglify      = require 'gulp-uglify'
sass        = require 'gulp-sass'

jsFilter = gulpFilter('**/*.js', '!**/*.min.js');

gulp.task 'default', [
  'browsersync'
], ->
  bowerSrc()
    .pipe(gulp.dest('dist/lib'));


gulp.task 'lint', ->
  gulp.src 'app/js/**/*.coffee'
  .pipe coffeelint()
  .pipe coffeelint.reporter()

gulp.task 'browserify', ->
  gulp.src 'app/js/app.js.coffee'
  .pipe browserify
    insertGlobals: true
    debug: true
  .pipe concat 'app.js'
  .pipe gulp.dest 'dist/js'

gulp.task 'build', [
  'build-js'
  'build-jade'
  'build-sass'
  'copy-assets'
]

gulp.task 'copy-assets', ->
  gulp.src 'app/assets/**/*'
  .pipe gulp.dest 'dist/assets'

gulp.task 'build-js', ['lint'], ->
  gulp.src 'app/js/**/*.coffee'
  .pipe coffee bare: true
  .pipe concat 'app.js'
  .pipe gulp.dest 'dist/js'
  .pipe reload({stream: true})
  .on 'error', gutil.log

gulp.task 'build-jade', ->
  gulp.src 'app/**/*.jade'
  .pipe jade()
  .pipe gulp.dest 'dist'

gulp.task 'build-sass', ->
  gulp.src 'app/stylesheet/**/*.sass'
  .pipe sass()
  .pipe gulp.dest 'dist/css'
  gulp.src 'app/stylesheet/**/*.css'
  .pipe gulp.dest 'dist/css'

gulp.task 'browsersync', ['nodemon'], ->
  gulp.start 'watch'
  console.log('called browsersync')
  browsersync.init null,
    proxy: 'http://localhost:5000'
    files: 'dist/**/*.*'
    browser: 'google chrome'
    port: 7000

gulp.task 'nodemon', (cb) ->
  started = false
  nodemon
    script: 'server.js.coffee'
    watch: ['server.js.coffee', 'models/*']
  .on 'restart', ->
    console.log('restarted')
    setTimeout ->
      reload(stream: false)
    , 1000
  .on 'start', ->
    console.log('calling start')
    if !started
      started = true
      cb()

gulp.task 'clean', ->
  gulp.src 'dist/*', {read : false}
  .pipe clean()

gulp.task 'watch', ['build'], ->
  gulp.watch 'app/js/**/*.coffee', [
    'lint'
    'build-js'
  ], reload({stream: true})
  gulp.watch 'app/**/*.jade', [
    'build-jade'
  ], reload({stream: true})
  gulp.watch 'app/stylesheet/**/*.sass', [
    'build-sass'
  ], reload({stream: true})
