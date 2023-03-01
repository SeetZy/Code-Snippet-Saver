const jwt = require('jsonwebtoken')

const UserModel = require('../models/user.model')

class UserService {
  static async registerUser(username, email, password) {
    try {
      const createUser = new UserModel({ username, email, password })
      return await createUser.save()
    } catch (error) {
      throw error
    }
  }

  static async checkuser(username, email) {
    try {
      return await UserModel.findOne({ username, email })
    } catch (error) {
      throw error
    }
  }

  static async generateToken(tokenData, secreyKey, jwt_expire) {
    return jwt.sign(tokenData, secreyKey, { expiresIn: jwt_expire })
  }
}

module.exports = UserService
