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

exports.login = async (req, res, next) => {
  try {
    const { username, email, password } = req.body
    const user = await UserService.checkuser(username, email)

    if (!user) {
      throw new Error('User does not exist')
    }

    const isMatch = await user.comparePassword(password)

    if (isMatch === false) {
      throw new Error('The password is invalid')
    }

    let tokenData = {
      _id: user._id,
      username: user.username,
      email: user.email,
    }

    const token = await UserService.generateToken(tokenData, 'test', '24h')

    res.status(200).json({ status: true, token: token })
  } catch (error) {
    throw error
  }
}
