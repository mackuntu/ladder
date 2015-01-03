var express = require('express');
var bodyParser = require('body-parser')
var config = require('./config');
var passport = require('passport');
var http = require('http');
var LocalStrategy = require('passport-local').Strategy;
var cookieParser = require('cookie-parser');
var morgan = require('morgan');
var session = require('express-session');


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
        res.send(401);
    else
        next();
};

var app = express();

app.set('port', process.env.PORT || 5000);
app.use(morgan('dev'));
app.use(cookieParser()); 
app.use(session({ 
    secret: 'securedsession',
    resave: false,
    saveUninitialized: true 
}));
app.use(passport.initialize()); // Add passport initialization
app.use(passport.session());    // Add passport initialization

app.use(express.static(__dirname + '/app'));
    //app.use(express.favicon());
app.use(bodyParser.json());


app.set('dbUrl', config.db[app.settings.env]);

require('angoose').init(app, {
    'module-dirs':'app/models',
    'mongo-opts': app.get('dbUrl'),
});


app.get('/', auth, function(req, res){
    res.render('index', { title: 'Express' });
});

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
  res.send(200);
});

http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});