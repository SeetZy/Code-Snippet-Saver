const app = require('./app');
const db = require('./config/db');
const userModel = require('./model/user.model');

const port = 5000;

app.get('/', (req, res) => {
    res.send("Hello world");
});

app.listen(port, () => {
    console.log(`Server running on port: ${port}`);
});
