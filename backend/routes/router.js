/**
 * * Library imports
 */
// ? https://www.npmjs.com/package/express
const express = require('express')

// Defining a router
const router = express.Router()

const dbFunctions = require('../methods/db.func')

// Default Route
router.get('/', (req, res) => {
  res.send('This is not meant to be viewed')
})

// Route to signup a new user
router.post('/signup', dbFunctions.signUp)

// Route to signin a new user
router.post('/signin', dbFunctions.signIn)

module.exports = router
