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
const bodyParser = require('body-parser')

const connectDb = require('./db/db')
const routes = require('./routes/router')

// Connects to MongoDb
connectDb()

// Define a new app
const app = express()

// Define the port
const port = process.env.PORT || 5000

// This code checks if the environment variable NODE_ENV is set to development and if so, it logs HTTP requests to the console using morgan's dev format
if (process.env.NODE_ENV === 'development') {
  app.use(morgan('dev'))
}

// This code enables Cross-Origin Resource Sharing (CORS)
app.use(cors())

// This code sets up body-parser middleware to handle JSON and URL encoded form data
app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())

// The application uses the routes that are defined in the router file
app.use(routes)

// This code initializes passport authentication middleware and configures it with the passport configuration
app.use(passport.initialize())
require('./config/passport')(passport)

// This code starts the server listening on the specified port
app.listen(port, () => {
  console.log(`Server running in ${process.env.NODE_ENV} mode on port: ${port}`)
})
