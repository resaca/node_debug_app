mongoose = require "mongoose"
config = require "./conf.json"
mongoose.connect "mongodb://#{config.dbHost}/#{config.dbName}"

require "../models"