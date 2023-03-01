const UserService = require('../services/user.services')

exports.register = async (req, res, next) => {
  try {
    const { email, password } = req.body
    const successRes = await UserService.registerUser(email, password)

    res.json({ status: true, success: 'User Registered' })
  } catch (error) {
    throw error
  }
}

exports.login = async (req, res, next) => {
  try {
    const { email, password } = req.body
    const user = await UserService.checkuser(email)

    if (!user) {
      throw new Error('User does not exist')
    }

    const isMatch = await user.comparePassword(password)

    if (isMatch === false) {
      throw new Error('The password is invalid')
    }

    let tokenData = {
      _id: user._id,
      email: user.email,
    }

    const token = await UserService.generateToken(tokenData, 'test', '24h')

    res.status(200).json({ status: true, token: token })
  } catch (error) {
    throw error
  }
}
