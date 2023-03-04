/**
 * * Library imports
 */
// ? https://www.npmjs.com/package/express
const express = require('express')

// Defining a router
const router = express.Router()

const userDbFunc = require('../methods/user.db.func')
const snippetDbFunc = require('../methods/snippet.db.func')

// Default Route
router.get('/', (req, res) => {
  res.send('This is not meant to be viewed')
})

// Route to signup a new user
router.post('/signup', userDbFunc.signUp)

// Route to signin a new user
router.post('/signin', userDbFunc.signIn)

// Route to logout a user
router.post('/logout', userDbFunc.logout)

// Route to create a new code snippet
router.post('/create-snippet', snippetDbFunc.createNewSnippet)

// Route to get users snippets
router.get('/get-user-snippets', snippetDbFunc.getUserSnippets)

module.exports = router
