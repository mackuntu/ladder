var express = require('express');
var bodyParser = require('body-parser')
var config = require('./config');
var passport = require('passport');
var http = require('http');
var LocalStrategy = require('passport-local').Strategy;
var cookieParser = require('cookie-parser');
var morgan = require('morgan');
var session = require('express-session');
var mongoose = require('mongoose');
mongoose.connect('mongodb://localhost/test');
var haml = require('hamljs');
var fs = require('fs');
var partials = require('express-partial');

// Create the express app, set port to 5000
var app = express();
app.set('port', process.env.PORT || 5000);

//==================================================================
// Begin setup authentication
//==================================================================

//==================================================================
// Define the strategy to be used by PassportJS
passport.use(new LocalStrategy(
  function(username, password, done) {
    if (username === "admin" && password === "admin") // stupid example
        return done(null, {name: "admin"});

    return done(null, false, { message: 'Incorrect username.' });
  }
));

// Serialized and deserialized methods when got from session
passport.serializeUser(function(user, done) {
    done(null, user);
});

passport.deserializeUser(function(user, done) {
    done(null, user);
});


// Middleware function to be used for every secured routes
var auth = function(req, res, next){
    if (!req.isAuthenticated())
        res.sendStatus(401);
    else
        next();
};

app.use(morgan('dev'));
app.use(cookieParser()); 
app.use(session({ 
    secret: 'securedsession',
    resave: false,
    saveUninitialized: true 
}));
app.use(passport.initialize()); // Add passport initialization
app.use(passport.session());    // Add passport initialization

//==================================================================
// End setup authentication
//==================================================================

app.use(express.static(__dirname + '/app'));
    //app.use(express.favicon());
app.use(bodyParser.json());
// let app use partial
//app.use(partials());

// register jade template engine
app.set('views', 'app/views');
app.set('view engine', 'jade');

app.set('dbUrl', config.db[app.settings.env]);

app.get('/', function(req, res){
    res.render('index', { title: 'Index', message: 'LadderApp initializing...'});
});

app.get('/partials/:name', function (req, res) { 
    var name = req.params.name;
    res.render('partials/' + name);
});

app.get('/login', function (req, res) {
    res.render('login');
});

app.get('/register', function (req, res) {
    res.render('register');
});

//==================================================================
// Begin Setup Mongoose schema and restful api
//==================================================================

var Player = mongoose.model('Player', {
            name: String,
            alias: String,
            company: String,
            group: String,
            suffix: String,
            email: String,
            updated: { type: Date, default: Date.now },
            rank: Number
            });

app.get('/players/', function (req, res) {
    Player.find({}, function(err, data){
        console.log(data);
        res.send(JSON.stringify(data));
    });
});

app.post('/player', function (req, res) {
    console.log(req.body);
    Player.find({
        alias: req.body.alias,
        company: req.body.company
    }, function(err, data){
        console.log(data);
        if (data.length){
            res.sendStatus(400);
        } else {
            newPlayer = new Player(req.body);
            Player.count({}, function(err, count){
                newPlayer.rank = count +1;
                newPlayer.save();
                res.sendStatus(200);
            });
        }
    })
});

//==================================================================
// End Setup Mongoose schema and restful api
//==================================================================

//==================================================================
// route to test if the user is logged in or not
app.get('/loggedin', function(req, res) {
  res.send(req.isAuthenticated() ? req.user : '0');
});

// route to log in
app.post('/login', passport.authenticate('local'), function(req, res) {
  res.send(req.user);
});

// route to log out
app.post('/logout', function(req, res){
  req.logOut();
  res.sendStatus(200);
});

http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});