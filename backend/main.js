/**
 * * Library imports
 */
// ? https://www.npmjs.com/package/express
const express = require('express')
// ? https://www.npmjs.com/package/morgan
const morgan = require('morgan')
// ? https://www.npmjs.com/package/cors
const cors = require('cors')
// ? https://www.npmjs.com/package/passport
const passport = require('passport')
// ? https://www.npmjs.com/package/body-parser
const { BodyParser } = require('body-parser')

const connectDb = require('./db/db')

// Connects to MongoDb
connectDb()

// Define a new app
const app = express()

// Define the port
const port = 5000

app.get('/', (req, res) => {
    res.send("Hello world")
});

app.listen(port, () => {
    console.log(`Server running on port: ${port}`)
});