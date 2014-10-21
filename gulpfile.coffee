gulp = require('gulp')
livereload = require('gulp-livereload')

gulp.task 'prepareTest', ->
  cjsx = require 'gulp-cjsx'
  gutil = require 'gulp-util'
  gulp.src 'app/react_js/**/*.cjsx'
    .pipe cjsx({bare: true}).on('error', gutil.log)
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

gulp.task 'prepareApp', ->
  browserify = require('browserify')
  source = require("vinyl-source-stream")
  rename = require 'gulp-rename'
  coffeeReactify = require 'coffee-reactify'
  b = browserify({extensions: ['.cjsx', '.js']})
  b.transform(coffeeReactify)
  b.add('./app/react_js/application.coffee')
  b.bundle()
    .pipe source('app/react_js/application.coffee')
    .pipe rename('application.js')
    .pipe gulp.dest 'app/assets/javascripts'
    .pipe livereload()

gulp.task 'watch', ->
  gulp.watch('app/react_js/**/*.cjsx', ['prepareApp', 'jest'])
