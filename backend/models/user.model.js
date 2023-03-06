/**
 * * Library imports
 */
// ? https://www.npmjs.com/package/mongoose
const mongoose = require('mongoose')
// ? https://www.npmjs.com/package/bcrypt
const bcrypt = require('bcrypt')

// Defines the schema object from mongoose
const Schema = mongoose.Schema

// Defines the user schema
const userSchema = new Schema({
  username: {
    type: String,
    require: true,
  },
  email: {
    type: String,
    require: true,
    unique: true,
  },
  password: {
    type: String,
    require: true,
  },
})

// Hashing the password before saving
userSchema.pre('save', function (next) {
  let user = this

  if (this.isModified('password') || this.isNew) {
    bcrypt.genSalt(15, function (err, salt) {
      if (err) {
        return next(err)
      }

      bcrypt.hash(user.password, salt, function (err, hash) {
        if (err) {
          return next(err)
        }

        user.password = hash
        next()
      })
    })
  } else {
    return next()
  }
})

// Compares the password that the user inputs
userSchema.methods.comparePassword = async function (userPassword) {
  try {
    const isMatch = await bcrypt.compare(userPassword, this.password)
    return isMatch
  } catch (error) {
    throw error
  }
}

module.exports = mongoose.model('users', userSchema)
