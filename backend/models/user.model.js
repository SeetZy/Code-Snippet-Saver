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
    email: {
        type: String,
        require: true,
        unique: true
    },
    password: {
        type: String,
        require: true
    }
})

// Hashing the password before saving
userSchema.pre('save', function(next) {
    let user = this;

    if (this.isModified('password') || this.isNew) {
        bcrypt.genSalt(15, function(err, salt) {
            if (err) {
                return next(err)
            }

            bcrypt.hash(user.password, salt, function(err, hash) {
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

// Compares the provided password with the hashed password
userSchema.methods.comparePassword = function(password, cb) {
    bcrypt.compare(password, this.password, function(err, isMatch) {
        if (err) {
            return cb(err)
        } 

        cb(null, isMatch)
    })
}

module.exports = mongoose.model('User', userSchema)
