/**
 * * Library imports
 */
// ? https://www.npmjs.com/package/mongoose
const mongoose = require('mongoose')
// ? https://www.npmjs.com/package/dotenv
require('dotenv').config()

// Gets the database url environment variable
const { DB_URL } = process.env

// Set strictQuery to true
mongoose.set('strictQuery', true)

// Creates and exports a function to connect to the database
module.exports = connectDb = async () => {
  try {
    // Connect to the MongoDb database using mongoose
    await mongoose
      .connect(DB_URL, {
        // Set the options for the connection
        useNewUrlParser: true,
        useUnifiedTopology: true,
      })
      .then(() => console.log(`Mongoose connected to MongoDb database`))
  } catch (error) {
    throw error
  }
}
