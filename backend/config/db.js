const mongoose = require('mongoose');

// Connects to the database
const connection = mongoose.createConnection('mongodb+srv://Admin:dVlO8Zja4PmJtMPL@cluster0.hjz08i9.mongodb.net/test').on('open', () => {
    console.log(`Mongoose connected to the database`);
}).on('error', () => {
    console.log('Mongoose ran into a error');
});

module.exports = connection;