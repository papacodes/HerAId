const express = require('express');
const bodyParser = require('body-parser');
const dotenv = require('dotenv');
dotenv.config(); 

const app = express();
const PORT = process.env.PORT || 3000;


app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));


const userRoutes = require('./routes/users'); 
app.use('/api/users', userRoutes); 


app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});