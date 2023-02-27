/**
 * * Library imports
 */
// ? https://www.npmjs.com/package/passport-jwt
const jwtStrategy = require('passport-jwt').Strategy
const extractJwt = require('passport-jwt').ExtractJwt

const User = require('../models/user.model')
const dbConfig = require('../db/db.config')

/**
 * Exporting Passport.js configuration
 * This function is used to define how Passport.js should handle authentication with JSON Web Tokens (JWT).
 */
module.exports = function (passport) {
  // Options object used to configure the strategy
  let options = {}

  // JWT secret used to sign and verify the token
  options.secretOrKey = dbConfig.secret
  // Method used to extract the JWT token from the request headers
  options.jwtFromRequest = extractJwt.fromAuthHeaderWithScheme('jwt')

  passport.use(
    new jwtStrategy(options, function (jwt_payload, done) {
      // This function will be called by Passport.js during the authentication process
      User.find(
        {
          id: jwt_payload.id,
        },
        function (err, User) {
          if (err) {
            return done(err, false)
          }

          if (User) {
            return done(null, User)
          } else {
            return done(null, false)
          }
        }
      )
    })
  )
}
