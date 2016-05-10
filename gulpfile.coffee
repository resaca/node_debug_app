gulp = require 'gulp'
require 'newrelic'

gulp.task 'devstart', ->
  app = require './app'
  app.env = 'development'
  app.listen 3000

gulp.task 'start', ->
  app = require './app'
  app.env = 'production'
  app.listen 3000
