express = require 'express'
router = express.Router()
passport = require 'passport'
foneVerify = require '../services/fone-verify'

# Local sign up route
router.post '/signup', (req, res, next) ->
  passport.authenticate('local-signup', (err, user, info) ->
    if err
      return next(err)
    if user
      res.json { id: user.id }
    else
      res.status(422).json { info }
    return
  ) req, res, next
  return

# Login
router.post '/signin', (req, res, next) ->
  passport.authenticate('local-login', (err, user, info) ->
    if err
      return next(err)
    if user
      res.json { id: user.id, email: user.local.email }
    else
      res.status(422).json { info }
    return
  ) req, res, next
  return

router.post '/otp', (req, res, next) ->
  fvresponse = foneVerify.send_otp(req.body.countryCode, req.body.phone)
  res.json { info: { success: true } }

module.exports = router
