express = require 'express'
require './config'
conf = require './config/conf.json'
path = require 'path'
favicon = require 'serve-favicon'
logger = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
app = express()
passport = require 'passport'
routes = require './routes'
LocalStrategy = require('passport-local').Strategy
app.set 'superSecret', conf.secret
require('./config/passport') passport # pass passport for configuration
app.set('port', process.env.PORT || 3000)
app.set('env', process.env.NODE_ENV || 'development')

# uncomment after placing your favicon in /public
#app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.set 'view engine', 'jade'
app.use logger 'dev'
app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: false)
app.use cookieParser()
app.use express.static path.join(__dirname, 'public')
app.use '/', routes

session = require 'express-session'
MongoStore = require('connect-mongo') session

app.use session(
  secret: 'dhbdsdbhsdsbhdsjdbsdhsjbdnskdsbdhscsxiwuqdgxi23uqwjdkhxiue'
  store: new MongoStore(
    url: "mongodb://#{conf.dbHost}/#{conf.sessionStore}"
  )
  resave:true
  saveUninitialized:true
)

app.use passport.initialize()

# catch 404 and forward to error handler
app.use (req, res, next) ->
  err = new Error('Not Found')
  err.status = 404
  next err
  return

# error handlers
# development error handler
# will print stacktrace
if app.get('env') == 'development'
  app.use (err, req, res, next) ->
    res.status err.status or 500
    res.send
      message: err.message
      error: err
    return

# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next) ->
  res.status err.status or 500
  res.send
    message: err.message
    error: {}
  return

app.listen app.get('port')

module.exports = app
