express = require 'express'
router = express.Router()

co = require 'co'
router.use '/auth', require('./auth')
# router.use '/users', require('./users')
router.use '/resources', require('./resources')

router.get '/terms', co.wrap (req, res, next) ->
  res.send { title: 'Express' }

router.get '/privacy', co.wrap (req, res, next) ->
  res.send { title: 'Express' }

router.get '/privacy', co.wrap (req, res, next) ->
  res.send { title: 'Express' }

module.exports = router
