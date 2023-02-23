const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const db = require('../config/db');

// Define a user schema
const userSchema = new mongoose.Schema({
    email: {
        type: String,
        required: true,
        unique: true
    },
    password: {
        type: String,
        required: true
    }
});

// Encrypts the user password before saving
userSchema.pre('save', async function() {
    try {
        let user = this;
        const salt = await bcrypt.genSalt(15);
        const hashPass = await bcrypt.hash(user.password, salt);

        user.password = hashPass;
    } catch (error) {
        throw error;
    }
})

// Makes a user model in the database
const userModel = db.model('user', userSchema);

module.exports = userModel;