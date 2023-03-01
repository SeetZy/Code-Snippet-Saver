/**
 * * Library imports
 */
// ? https://www.npmjs.com/package/express
const express = require('express')

// Defining a router
const router = express.Router()

const UserController = require('../controller/user.controller')

// Default Route
router.get('/', (req, res) => {
  res.send('This is not meant to be viewed')
})

// Route to signup a new user
router.post('/signup', UserController.register)

// Route to signin a new user
router.post('/signin', UserController.login)

module.exports = router
