gulp = require('gulp')
livereload = require('gulp-livereload')
notify = require("gulp-notify")
plumber = require('gulp-plumber')

notifyError = (error) ->
  notify.onError(
    title:    "Gulp",
    subtitle: "Error",
    message:  "Error: <%= error.message %>"
  )(error)

OnError = (error) ->
  notifyError(error)
  this.emit('end')

gulp.task 'prepareTest', ->
  cjsx = require 'gulp-cjsx'
  gutil = require 'gulp-util'
  gulp.src 'app/react_js/**/*.cjsx'
    .pipe plumber({errorHandler: OnError})
    .pipe cjsx({bare: true})
    .pipe gulp.dest 'spec/javascripts/src'

gulp.task 'jest', ['prepareTest'], ->
  jest = require('gulp-jest')
  gulp.src './spec/javascripts'
    .pipe jest
      scriptPreprocessor: "./preprocessor.js"
      unmockedModulePathPatterns: ["node_modules/react"]
      testDirectoryName: "tests"
      testPathIgnorePatterns: [
          "node_modules",
          "spec/support"
      ]
      testFileExtensions: ["coffee"]
    .pipe(notify("Tests Success"))

gulp.task 'prepareApp', ->
  browserify = require('browserify')
  source = require("vinyl-source-stream")
  rename = require 'gulp-rename'
  coffeeReactify = require 'coffee-reactify'
  b = browserify({extensions: ['.cjsx', '.js']})
  b.transform(coffeeReactify)
  b.add('./app/react_js/application.coffee')
  b.bundle()
    .on 'error', OnError
    .pipe source('app/react_js/application.coffee')
    .pipe rename('application.js')
    .pipe gulp.dest 'app/assets/javascripts'
    .pipe livereload()
    .pipe(notify("App Success"))

gulp.task 'watch', ['prepareApp', 'jest'], ->
  gulp.watch('app/react_js/**/*.cjsx', ['prepareApp', 'jest'])