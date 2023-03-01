const UserService = require('../services/user.services')

exports.register = async (req, res, next) => {
  try {
    const { username, email, password } = req.body
    const successRes = await UserService.registerUser(username, email, password)

    res.json({ status: true, success: 'User Registered' })
  } catch (error) {
    throw error
  }
}
