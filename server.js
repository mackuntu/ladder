var express = require('express');
var bodyParser = require('body-parser')

var app = express();

app.use(express.static(__dirname + '/app'));
    //app.use(express.favicon());
app.use(bodyParser.json());

var config = require('./config');
app.set('dbUrl', config.db[app.settings.env]);

require('angoose').init(app, {
    'module-dirs':'app/models',
    'mongo-opts': app.get('dbUrl'),
});

app.listen(process.env.PORT || 5000);