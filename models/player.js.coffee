mongoose = require 'mongoose'
Schema = mongoose.Schema

PlayerSchema = new Schema(
  firstName: String
  lastName: String
  alias: String
  company: String
  group: String
  suffix: String
  email: String
  updated:
    type: Date
    default: Date.now
  rank: Number
  historyString: String
  challenges: [
    type: Schema.Types.ObjectId
    ref: 'Challenge'
  ]
  defenses: [
    type: Schema.Types.ObjectId
    ref: 'Challenge'
  ]
)

module.exports = mongoose.model('Player', PlayerSchema)
