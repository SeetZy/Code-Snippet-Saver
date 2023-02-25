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
const port = process.env.port || 5000

if (process.env.NODE_ENV === 'development') {
    app.use(morgan('dev'))
}

app.use(cors())
app.use(bodyParser.urlencoded({extended: false}))
app.use(bodyParser.json())
// The application uses the routes that are defined in the router file
app.use(routes)
app.use(passport.initialize())
require('./config/passport')(passport)

app.listen(port, () => {
    console.log(`Server running in ${process.env.NODE_ENV} mode on port: ${port}`)
});