/**
 * * Library imports
 */
// ? https://www.npmjs.com/package/mongoose
const mongoose = require('mongoose')

// Gets the user schema
const UserModel = require('./user.model')

// Defines the schema object from mongoose
const Schema = mongoose.Schema

// Defines the user schema
const snippetSchema = new Schema({
  userId: {
    type: Schema.Types.ObjectId,
    ref: UserModel.modelName,
  },
  fileName: {
    type: String,
    require: true,
  },
  fileType: {
    type: String,
    require: true,
  },
  snippet: {
    type: String,
    require: true,
  },
  description: {
    type: String,
    require: true,
  },
})

module.exports = mongoose.model('snippets', snippetSchema)
