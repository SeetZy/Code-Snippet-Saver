const jwtStrategy = require('passport-jwt').Strategy
const extractJwt = require('passport-jwt').ExtractJwt

const User = require('../models/user.model')
const dbConfig = require('../db/db.config')

module.exports = function(passport) {
    let options = {}

    options.secretOrKey = dbConfig.secret
    options.jwtFromRequest = extractJwt.fromAuthHeaderWithScheme('jwt')

    passport.use(new jwtStrategy(options, function(jwt_payload, done) {
        User.find({
            id: jwt_payload.id
        }, function(err, User) {
            if (err) {
                return done(err, false)
            }

            if (User) {
                return done(null, User)
            } else {
                return done(null, false)
            }
        })
    }))
}