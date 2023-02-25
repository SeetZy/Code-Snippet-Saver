/**
 * * Library imports
 */
// ? https://www.npmjs.com/package/jwt-simple
const jwt = require('jwt-simple')

const User = require('../models/user.model')
const config = require('../db/db.config')

module.exports = functions = {
    addNew: function(req, res) {
        if ((!req.body.email) || (!req.body.password)) {
            res.json({success: false, msg: 'Enter all fields'})
        } else {
            let newUser = User({
                email: req.body.email,
                password: req.body.password
            })

            newUser.save(function(err, newUser) {
                if (err) {
                    res.json({success: false, msg: 'Failed to save the user'})
                } else {
                    res.json({success: true, msg: 'Saved the user successfully'})
                }
            })
        }
    },
    authenticate: function(req, res) {
        User.findOne({
            email: req.body.email
        }, function(err, User) {
            if (err) throw err

            if (!User) {
                res.status(403).send({success: false, msg: 'Authentication has failed, no matching user has been found'})
            } else {
                User.comparePassword(req.body.password, function(err, isMatch) {
                    if (isMatch && !err) {
                        let token = jwt.encode(User, config.secret)
                        res.json({success: true, token: token})
                    } else {
                        return res.status(403).send({success: false, msg: 'Authentification has failed incorrect password'})
                    }
                })
            }
        })
    },
    getInfo: function(req, res) {
        if (req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer') {
            let token = req.headers.authorization.split(' ')[1]
            let decodedtoken = jwt.decode(token, config.secret)

            return res.json({success: true, msg: 'Hello ' + decodedtoken.email})
        } else {
            return res.json({success: false, msg: 'No headers'})
        }
    }
}