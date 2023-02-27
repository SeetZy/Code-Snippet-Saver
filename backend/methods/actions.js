/**
 * * Library imports
 */
// ? https://www.npmjs.com/package/jwt-simple
const jwt = require('jwt-simple')

const User = require('../models/user.model')
const config = require('../db/db.config')

// Defines functions object to be exported
module.exports = functions = {
  // Function to add new user to the database
  signUp: function (req, res) {
    if (!req.body.email || !req.body.password) {
      res.json({ success: false, msg: 'Enter all fields' })
    } else {
      // Creating a new user object with email and password
      let newUser = User({
        email: req.body.email,
        password: req.body.password,
      })

      // Saving the new user object to the database
      newUser.save(function (err, newUser) {
        if (err) {
          res.json({ success: false, msg: 'Failed to save the user' })
        } else {
          res.json({ success: true, msg: 'Saved the user successfully' })
        }
      })
    }
  },

  // Function to authenticate the user and return a token
  signIn: function (req, res) {
    User.findOne(
      {
        email: req.body.email,
      },
      function (err, User) {
        if (err) throw err

        if (!User) {
          // If no user with matching email is found
          res
            .status(403)
            .send({
              success: false,
              msg: 'Authentication has failed, no matching user has been found',
            })
        } else {
          // If user with matching email is found, compare the provided password with the hashed password
          User.comparePassword(req.body.password, function (err, isMatch) {
            if (isMatch && !err) {
              // If passwords match, create a token with the user object and secret key and send it back
              let token = jwt.encode(User, config.secret)
              res.json({ success: true, token: token })
            } else {
              // If passwords don't match
              return res
                .status(403)
                .send({
                  success: false,
                  msg: 'Authentification has failed incorrect password',
                })
            }
          })
        }
      }
    )
  },

  // Function to get user info from the token
  getInfo: function (req, res) {
    if (
      req.headers.authorization &&
      req.headers.authorization.split(' ')[0] === 'Bearer'
    ) {
      // If authorization header is present and the format is 'Bearer <token>'
      let token = req.headers.authorization.split(' ')[1]
      let decodedtoken = jwt.decode(token, config.secret)

      // Extracting user email from the decoded token and sending it back
      return res.json({ success: true, msg: 'Hello ' + decodedtoken.email })
    } else {
      // If authorization header is not present or not in the correct format
      return res.json({ success: false, msg: 'No headers' })
    }
  },
}
