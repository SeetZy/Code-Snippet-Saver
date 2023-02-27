/**
 * * Library imports
 */
// ? https://www.npmjs.com/package/jwt-simple
const jwt = require('jwt-simple')

// Get the user model
const User = require('../models/user.model')
// Get the db secret
const dbSecret = require('../db/db.secret')

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
          res.status(403).send({
            success: false,
            msg: 'Authentication has failed, no matching user has been found',
          })
        } else {
          // If user with matching email is found, compare the provided password with the hashed password
          User.comparePassword(req.body.password, function (err, isMatch) {
            if (isMatch && !err) {
              // If passwords match, create a token with the user object and secret key and send it back
              let token = jwt.encode(User, dbSecret.secret)
              res.json({ success: true, token: token })
            } else {
              // If passwords don't match
              return res.status(403).send({
                success: false,
                msg: 'Authentification has failed incorrect password',
              })
            }
          })
        }
      }
    )
  },
}
