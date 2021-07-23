require('dotenv').config();

const express = require('express');
const apiRouter = require('./app/routers/api');
const websiteRouter = require('./app/routers/website');


const app = express();

app.set('view engine', 'ejs');
app.set('views', './app/views');

// body parser
app.use(express.json());


app.use('/api', apiRouter);
app.use('/', websiteRouter);

const port = process.env.PORT || `3000`;



app.listen(port, () => {
    console.log(`Server started on http://localhost:${port}`);
});