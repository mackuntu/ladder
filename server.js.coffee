express = require('express')
bodyParser = require('body-parser')
config = require('./config')
passport = require('passport')
http = require('http')
LocalStrategy = require('passport-local').Strategy
cookieParser = require('cookie-parser')
morgan = require('morgan')
session = require('express-session')
mongoose = require('mongoose')
env = process.env.ENV
if env
  mongoose.connect process.env.MONGOHQ_URL
else
  mongoose.connect 'mongodb://localhost/test'
fs = require('fs')
partials = require('express-partial')
# Create the express app, set port to 5000
app = express()
app.set 'port', process.env.PORT or 5000
#==================================================================
# Begin setup authentication
#==================================================================
#==================================================================
# Define the strategy to be used by PassportJS
passport.use new LocalStrategy((username, password, done) ->
  if username == 'admin' and password == 'admin'
    return done(null, name: 'admin')
  done null, false, message: 'Incorrect username.'
)
# Serialized and deserialized methods when got from session
passport.serializeUser (user, done) ->
  done null, user
  return
passport.deserializeUser (user, done) ->
  done null, user
  return
# Middleware function to be used for every secured routes

auth = (req, res, next) ->
  if !req.isAuthenticated()
    res.sendStatus 401
  else
    next()
  return

app.use morgan('dev')
app.use cookieParser()
app.use session(
  secret: 'securedsession'
  resave: false
  saveUninitialized: true)
app.use passport.initialize()
# Add passport initialization
app.use passport.session()
# Add passport initialization
#==================================================================
# End setup authentication
#==================================================================
app.use express.static(__dirname + '/dist')
app.use express.static(__dirname + '/dist/views')
#app.use(express.favicon());
app.use bodyParser.json()
# let app use partial
#app.use(partials());
# register jade template engine
app.set 'dbUrl', config.db[app.settings.env]
app.get '/', (req, res) ->
  res.render 'index',
    title: 'Index'
    message: 'LadderApp initializing...'
  return

app.get '/login', (req, res) ->
  res.render 'login'
  return
app.get '/register', (req, res) ->
  res.render 'register'
  return
#==================================================================
# Begin Setup Mongoose schema and restful api
#==================================================================
Player = mongoose.model('Player',
  name: String
  alias: String
  company: String
  group: String
  suffix: String
  email: String
  updated:
    type: Date
    default: Date.now
  rank: Number)
app.get '/players/', (req, res) ->
  Player.find {}, (err, data) ->
    console.log data
    res.send JSON.stringify(data)
    return
  return
app.post '/player', (req, res) ->
  console.log req.body
  Player.find {
    alias: req.body.alias
    company: req.body.company
  }, (err, data) ->
    console.log data
    if data.length
      res.sendStatus 400
    else
      newPlayer = new Player(req.body)
      Player.count {}, (err, count) ->
        newPlayer.rank = count + 1
        newPlayer.save()
        res.sendStatus 200
        return
    return
  return
#==================================================================
# End Setup Mongoose schema and restful api
#==================================================================
#==================================================================
# route to test if the user is logged in or not
app.get '/loggedin', (req, res) ->
  res.send if req.isAuthenticated() then req.user else '0'
  return
# route to log in
app.post '/login', passport.authenticate('local'), (req, res) ->
  res.send req.user
  return
# route to log out
app.post '/logout', (req, res) ->
  req.logOut()
  res.sendStatus 200
  return
http.createServer(app).listen app.get('port'), ->
  console.log 'Express server listening on port ' + app.get('port')
  return