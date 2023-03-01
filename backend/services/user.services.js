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
}

module.exports = UserService
