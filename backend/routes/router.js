/**
 * * Library imports
 */
// ? https://www.npmjs.com/package/express
const express = require('express')

const actions = require('../methods/actions')

// Defining a router
const router = express.Router()

// Default Route
router.get('/', (req, res) => {
    res.send('This is not meant to be viewed')
})

// Route to signup a new user
router.post('/signup', actions.addNew)

// Route to signin a new user
router.post('/signin', actions.authenticate)

module.exports = router
