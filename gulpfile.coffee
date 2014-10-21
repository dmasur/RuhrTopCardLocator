gulp = require('gulp')
react = require('gulp-react')
jest = require('gulp-jest')
browserify = require('browserify')
reactify = require('reactify')
source = require("vinyl-source-stream")
rename = require 'gulp-rename'

gulp.task 'prepareTest', ->
  gulp.src 'app/assets/javascripts/**/*.jsx'
    .pipe react(harmony: true)
    .pipe gulp.dest 'spec/javascripts/harness/src'

gulp.task 'jest', ['prepareTest'], ->
  gulp.src './spec/javascripts/harness'
    .pipe jest
      scriptPreprocessor: "./preprocessor.js"
      unmockedModulePathPatterns: [
          "node_modules/react"
      ]
      testDirectoryName: "__tests__"
      testPathIgnorePatterns: [
          "node_modules",
          "spec/support"
      ]
      testFileExtensions: [
          "js",
          "coffee"
      ]
gulp.task 'prepareApp', ->
  b = browserify()
  b.transform(reactify)
  b.add('./app/react_js/application.js')
  b.bundle()
    .pipe(source('app/react_js/application.js'))
    .pipe rename('application.js')
    .pipe gulp.dest 'app/assets/javascripts'
