/**
 * * Library imports
 */
// ? https://www.npmjs.com/package/mongoose
const mongoose = require('mongoose')
// ? https://www.npmjs.com/package/bcrypt
const bcrypt = require('bcrypt')

const Schema = mongoose.Schema

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

userSchema.methods.comparePassword = function(password, cb) {
    bcrypt.compare(password, this.password, function(err, isMatch) {
        if (err) {
            return cb(err)
        } 

        cb(null, isMatch)
    })
}

module.exports = mongoose.model('User', userSchema)