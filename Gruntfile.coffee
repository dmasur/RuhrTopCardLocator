'use strict'

module.exports = (grunt) ->
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  paths = {
    dist: 'public/assets'
    tmp: 'tmp/grunt_tasks/'
    vendor: 'vendor/'
    src:
      app: 'app/assets/javascripts/app.js'
      app_dir: 'app/assets/javascripts'
      test: 'spec/javascripts/harness/src'
    temp:
      react: 'spec/javascripts/harness/src'
      browserify: 'tmp/javascripts/build.js'
      app: 'spec/javascripts/harness/application.js'
  }

  grunt.initConfig
    paths: paths
    pkg: grunt.file.readJSON('package.json')

    jshint:
      files: [
        'Gruntfile.js',
        'spec/javascripts/harness/react'
        ]
      options:
        globals:
          jQuery: true
          console: true
          module: true
          document: true

    react:
      dynamic_mappings:
        files: [
          expand: true
          cwd: '<%= paths.src.app_dir %>'
          src: ['**/*.jsx']
          dest: '<%= paths.temp.react %>'
          ext: '.js'
        ]

    watch:
      files: [
        'Gruntfile.js',
        'spec/javascripts/harness/__tests__/*.coffee',
        'app/assets/javascripts/react/**/*',
        'app/assets/javascripts/templates/**/*'
      ]
      tasks: ['default']

    browserify:
      client:
        src: ['<%= paths.temp.react %>/**/*.js']
        dest: '<%= paths.src.app %>'
        options:
          external: ['jQuery', 'react']
      test:
        src: ['<%= paths.temp.react %>/**/*.js']
        dest: '<%= paths.temp.react %>/../app.js'
        options:
          external: ['jQuery', 'react']

    concat:
      options:
        separator: ''
      app:
        src: [
          '<%= paths.temp.react %>/**/*.js',
          'spec/javascripts/harness/exports.js'
        ]
        dest: '<%= paths.src.app %>'

  require('load-grunt-tasks')(grunt)

  grunt.registerTask('default', ['react', 'browserify', 'jest'])
