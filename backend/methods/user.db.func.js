/**
 * * Library imports
 */
// ? https://www.npmjs.com/package/jsonwebtoken
const jwt = require('jsonwebtoken')

// Gets the data models
const UserModel = require('../models/user.model')
const BlacklistedToken = require('../models/blacklisted.tokens.model')

class UserService {
  // Method for registering a new user
  static async signUpUser(email, password) {
    try {
      const createUser = new UserModel({ email, password })
      return await createUser.save()
    } catch (error) {
      throw new Error(`Failed to register user: ${error.message}`)
    }
  }

  // Method for checking if a user exists in the database
  static async checkUser(email) {
    try {
      return await UserModel.findOne({ email })
    } catch (error) {
      throw new Error(`Failed to check user: ${error.message}`)
    }
  }

  // Method for generating a JWT token
  static async generateToken(tokenData, secretKey, jwtExpire) {
    const token = jwt.sign(tokenData, secretKey, { expiresIn: jwtExpire })
    const blacklistedToken = await BlacklistedToken.findOne({ token })
    if (blacklistedToken) {
      throw new Error('Token has been blacklisted')
    }
    return token
  }
}

// Defines functions object to be exported
module.exports = userDbFunc = {
  // Exporting the signUp function for user registration
  signUp: async (req, res, next) => {
    try {
      const { email, password } = req.body
      const user = await UserService.checkUser(email)

      // Checks if a user with the provided email already exists
      if (user) {
        // If there is a user with the provided email
        res
          .status(400)
          .json({ status: false, error: 'User with that email already exists' })
        return
      } else if (!user) {
        // If there isn't a user with the provided email
        const successRes = await UserService.signUpUser(email, password)

        res.json({ status: true, success: 'User Registered' })
      }
    } catch (error) {
      console.error(error.message)
      res.status(500).json({ status: false, error: 'Failed to register user' })
    }
  },

  // Exporting the signIn function for user authentication
  signIn: async (req, res, next) => {
    try {
      const { email, password } = req.body
      const user = await UserService.checkUser(email)

      // Checks if a user with the provided email already exists

      if (user) {
        // If there is a user with the provided email
        // Compares the passwords, and checks if they match
        const isMatch = await user.comparePassword(password)

        if (isMatch) {
          // If the provided passwords do not match
          const tokenData = {
            _id: user._id,
            email: user.email,
          }

          // Generates a token
          const token = await UserService.generateToken(
            tokenData,
            'test',
            '24h'
          )

          res.status(200).json({ status: true, token })
        } else if (!isMatch) {
          // If the provided passwords do not match
          res.status(400).json({ status: false, error: 'Invalid password' })
          return
        }
      } else if (!user) {
        // If there isn't a user with the provided email
        res.status(400).json({ status: false, error: 'User does not exist' })
        return
      }
    } catch (error) {
      console.error(error.message)
      res.status(500).json({ status: false, error: 'Failed to login' })
    }
  },

  logout: async (req, res, next) => {
    try {
      const authHeader = req.headers.authorization
      if (!authHeader) {
        return res
          .status(401)
          .json({ status: false, error: 'Authorization header is missing' })
      }
      const token = authHeader.split(' ')[1] // Extracts the token from the Authorization header
      await BlacklistedToken.create({ token })
      res.json({ status: true, message: 'Logged out successfully' })
    } catch (error) {
      console.error(error.message)
      res.status(500).json({ status: false, error: 'Failed to logout' })
    }
  },
}
