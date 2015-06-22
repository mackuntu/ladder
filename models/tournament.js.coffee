mongoose = require 'mongoose'
Schema = mongoose.Schema

TournamentSchema = new Schema(
  primaryOwner:
    type: Schema.Types.ObjectId
    ref: 'Player'
  secondaryOwner:
    type: Schema.Types.ObjectId
    ref: 'Player'
  winner:
    type: Schema.Types.ObjectId
    ref: 'Player'
  timeCreated:
    type: Date
    default: Date.now
  timeCompleted:
    type: Date
  completed: Boolean
  location: String
  duration: Number
  group: String
  company: String
  maxPlayers: Number
)

module.exports.Tournament = mongoose.model('Tournament', TournamentSchema)