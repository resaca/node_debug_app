express = require 'express'
router = express.Router()
countries = require '../resources/countries.json'

co = require 'co'

# List country names and codes
router.get '/countries', co.wrap (req, res, next) ->
  res.send countries

module.exports = router
