const mongoose = require('mongoose')

// Defines the schema object from mongoose
const Schema = mongoose.Schema

const BlacklistedTokenSchema = new Schema({
  token: {
    type: String,
    required: true,
  },
  blacklistedAt: {
    type: Date,
    default: Date.now,
  },
})

module.exports = mongoose.model('BlacklistedToken', BlacklistedTokenSchema)
