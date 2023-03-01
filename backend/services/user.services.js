const jwt = require('jsonwebtoken')

const UserModel = require('../models/user.model')

class UserService {
  static async registerUser(email, password) {
    try {
      const createUser = new UserModel({ email, password })
      return await createUser.save()
    } catch (error) {
      throw error
    }
  }

  static async checkuser(email) {
    try {
      return await UserModel.findOne({ email })
    } catch (error) {
      throw error
    }
  }

  static async generateToken(tokenData, secreyKey, jwt_expire) {
    return jwt.sign(tokenData, secreyKey, { expiresIn: jwt_expire })
  }
}

module.exports = UserService
