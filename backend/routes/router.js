/**
 * * Library imports
 */
// ? https://www.npmjs.com/package/express
const express = require('express')

const actions = require('../methods/actions')

// Defining a router
const router = express.Router()

router.get('/', (req, res) => {
    res.send('Hello world')
})

router.get('/dashboard', (req, res) => {
    res.send('Dashboard')
})

// Route to signup a new user
router.post('/signup', actions.addNew)

// Route to signin a new user
router.post('/signin', actions.authenticate)

router.get('/getinfo', actions.getInfo)

module.exports = router