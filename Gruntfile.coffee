'use strict'

module.exports = (grunt) ->
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  paths = {
    dist: 'public/assets'
    tmp: 'tmp/grunt_tasks/'
    client:
      compiled: 'app/assets/javascripts/compiled.js'
    test:
      compiled: 'spec/javascripts/harness/compiled.js'
    src:
      app_dir: 'app/assets/javascripts'
    temp:
      react: 'spec/javascripts/harness/src'
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
        dest: '<%= paths.client.compiled %>'
        options:
          external: ['jQuery', 'react']
      test:
        src: ['<%= paths.temp.react %>/**/*.js']
        dest: '<%= paths.test.compiled %>'
        options:
          external: ['jQuery', 'react']

  require('load-grunt-tasks')(grunt)

  grunt.registerTask('default', ['react', 'browserify', 'jest'])
