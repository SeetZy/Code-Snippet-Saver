/**
 * * Library imports
 */
// ? https://www.npmjs.com/package/jsonwebtoken
const jwt = require('jsonwebtoken')

// Gets the data models
const UserModel = require('../models/user.model')
const SnippetModel = require('../models/snippet.model')

class UserService {
  // Method for registering a new user
  static async signUpUser(username, email, password) {
    try {
      // Creates a new user
      const createUser = new UserModel({ username, email, password })

      // Saves the user to the database
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
    return jwt.sign(tokenData, secretKey, { expiresIn: jwtExpire })
  }

  // Method for updating a users username and email
  static async updateData(id, username, email) {
    // Finds the designated user and updates it
    const updatedUserData = await UserModel.findByIdAndUpdate(
      { _id: id },
      { username, email },
      { new: true }
    )

    return updatedUserData
  }

  // Method for deleting all user data
  static async deleteUser(id) {
    // Finds the user profile data and deletes it
    const deletedUserData = await UserModel.findOneAndDelete({ _id: id })
    // Finds every code snippet that the user "owns" and deletes it
    const deletedUserSnippets = await SnippetModel.deleteMany({
      userId: id,
    })

    return deletedUserSnippets, deletedUserData
  }
}

// Defines functions object to be exported
module.exports = userDbFunc = {
  // Exporting the signUp function for user registration
  signUp: async (req, res, next) => {
    try {
      const { username, email, password } = req.body
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
        const successRes = await UserService.signUpUser(
          username,
          email,
          password
        )

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
      const { username, email, password } = req.body
      const user = await UserService.checkUser(email)

      // Checks if a user with the provided email already exists

      if (user) {
        // If there is a user with the provided email
        // Compares the passwords, and checks if they match
        const isMatch = await user.comparePassword(password)

        if (isMatch) {
          // If the provided passwords match
          const tokenData = {
            _id: user._id,
            username: user.username,
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

  // Exporting the updateUserData function for updating user data
  updateUserData: async (req, res, next) => {
    try {
      const { id } = req.params
      const { username, email } = req.body

      let updatedData = await UserService.updateData(id, username, email)

      res.json({ status: true, success: updatedData })
    } catch (error) {
      next(error)
    }
  },

  // Exporting the deleteUserData function for deleting all user data
  deleteUserData: async (req, res, next) => {
    try {
      const { id } = req.body

      let deletedData = await UserService.deleteUser(id)

      res.json({ status: true, success: deletedData })
    } catch (error) {
      next(error)
    }
  },
}
