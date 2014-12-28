var angoose = require("angoose");

var mongoose = angoose.getMongoose();

mongoose.set('debug', true);

var playerSchema = mongoose.Schema({
    name: String,
    rank: Number
});

module.exports = mongoose.model('Player', playerSchema)
