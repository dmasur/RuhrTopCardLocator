gulp = require('gulp')
react = require('gulp-react')
jest = require('gulp-jest')
browserify = require('gulp-browserify')

gulp.task 'prepareTest', ->
  gulp.src 'app/assets/javascripts/**/*.jsx'
    .pipe react()
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
  gulp.src 'app/assets/javascripts/**/*.jsx'
    .pipe browserify
      insertGlobals : true,
      debug : true
    .pipe gulp.dest 'app/assets/javascripts/compiled'
