/**
 * * Library imports
 */
// ? https://www.npmjs.com/package/express
const express = require('express');

// Get the database functions
const dbFunc = require('../methods/db.func');

// Defining a router
const router = express.Router();

// Default Route
router.get('/', (req, res) => {
  res.send('This is not meant to be viewed');
});

// Route to signup a new user
router.post('/signup', dbFunc.signUp);

// Route to signin a new user
router.post('/signin', dbFunc.signIn);

module.exports = router;
