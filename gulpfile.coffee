gulp = require('gulp')
livereload = require('gulp-livereload')
notify = require("gulp-notify")
plumber = require('gulp-plumber')

OnError = (error) ->
  notify.onError(
    title:    "Gulp",
    subtitle: "Error",
    message:  "Error: <%= error.message %>"
  )(error)
  this.emit('end')

gulp.task 'prepareTest', ->
  cjsx = require 'gulp-cjsx'
  gutil = require 'gulp-util'
  gulp.src ['app/javascripts/**/*.cjsx', 'app/javascripts/**/*.coffee']
    .pipe plumber({errorHandler: OnError})
    .pipe cjsx({bare: true})
    .pipe gulp.dest 'spec/javascripts/src'

gulp.task 'jest', ['prepareTest'], ->
  jest = require('gulp-jest')
  gulp.src './spec/javascripts'
    .pipe plumber({errorHandler: OnError})
    .pipe jest
      scriptPreprocessor: "./preprocessor.js"
      unmockedModulePathPatterns: [
        "node_modules/react",
        "node_modules/fluxxor-jest-utils",
        "jquery"
        ]
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
  b = browserify({extensions: ['.cjsx', '.js', '.coffee']})
  b.transform(coffeeReactify)
  b.add('./app/javascripts/application.coffee')
  b.bundle()
    .on 'error', OnError
    .pipe source('app/javascripts/application.coffee')
    .pipe rename('application.js')
    .pipe gulp.dest 'app/assets/javascripts'
    .pipe livereload()
    .pipe(notify("App Success"))

gulp.task 'watch', ['prepareApp', 'jest'], ->
  gulp.watch('app/javascripts/**/*.*', ['prepareApp', 'jest'])
  gulp.watch('spec/javascripts/**/*.coffee', ['jest'])
