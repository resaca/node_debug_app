# load all the things we need
LocalStrategy = require('passport-local').Strategy

# load up the user model
User = require('../../models/user')

# expose this function to our app using module.exports
module.exports = (passport) ->
  # =========================================================================
  # passport session setup ==================================================
  # =========================================================================
  # required for persistent login sessions
  # passport needs ability to serialize and unserialize users out of session

  # used to serialize the user for the session
  passport.serializeUser (user, done) ->
    done null, user.id
    return

  # used to deserialize the user
  passport.deserializeUser (id, done) ->
    User.findById id, (err, user) ->
      done err, user
      return
    return

  # =========================================================================
  # LOCAL SIGNUP ============================================================
  # =========================================================================
  # we are using named strategies since we have one for login and one for signup
  # by default, if there was no name, it would just be called 'local'

  passport.use 'local-signup', new LocalStrategy({
    usernameField: 'email'
    passwordField: 'password'
    passReqToCallback: true
  }, (req, email, password, done) ->
    # asynchronous
    # User.findOne wont fire unless data is sent back
    process.nextTick ->
      # find a user whose email is the same as the forms email
      # we are checking to see if the user trying to login already exists
      User.findOne { 'local.email': email }, (err, user) ->
        # if there are any errors, return the error
        if err
          return done(err)
        # check to see if theres already a user with that email
        if user
          return done null, false, message: 'That email is already taken.'
        else
          # if there is no user with that email
          # create the user
          newUser = new User
          # set the user's local credentials
          newUser.local.email = email
          newUser.local.password = newUser.generateHash(password)
          # save the user
          newUser.save (err) ->
            if err
              throw err
            done null, newUser
        return
      return
    return
  )

  passport.use 'local-login', new LocalStrategy({
    usernameField: 'email'
    passwordField: 'password'
    passReqToCallback: true
  }, (req, email, password, done) ->
    # callback with email and password from our form
    # find a user whose email is the same as the forms email
    # we are checking to see if the user trying to login already exists
    User.findOne { 'local.email': email }, (err, user) ->
      # if there are any errors, return the error before anything else
      if err
        return done(err)
      # if no user is found, return the message
      if !user
        return done null, false, message: 'No user found.'
      # req.flash is the way to set flashdata using connect-flash
      # if the user is found but the password is wrong
      if !user.validPassword(password)
        return done null, false, message: 'Oops! Wrong password.'
      # create the loginMessage and save it to session as flashdata
      # all is well, return successful user
      done null, user
    return
  )
