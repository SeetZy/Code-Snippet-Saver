/**
 * * Library imports
 */
// ? https://www.npmjs.com/package/express
const express = require('express')

// Defining a router
const router = express.Router()

// Gets all the methods
const userDbFunc = require('../methods/user.db.func')
const snippetDbFunc = require('../methods/snippet.db.func')

// Default Route
router.get('/', (req, res) => {
  res.send('This is not meant to be viewed')
})

// User Routes
// Route to signup a new user
router.post('/signup', userDbFunc.signUp)
// Route to signin a new user
router.post('/signin', userDbFunc.signIn)
// Route to update user data
router.put('/update-user-data/:id', userDbFunc.updateUserData)
// Route to delete a user
router.delete('/delete-user', userDbFunc.deleteUserData)

// Snippet Routes
// Route to create a new code snippet
router.post('/create-snippet', snippetDbFunc.createNewSnippet)
// Route to get users snippets
router.get('/get-user-snippets', snippetDbFunc.getUserSnippets)
// Route to update users snippets
router.put('/update-snippets/:id', snippetDbFunc.updateUserSnippets)
// Route to delete users snippets
router.delete('/delete-snippets', snippetDbFunc.deleteUserSnippets)

module.exports = router
