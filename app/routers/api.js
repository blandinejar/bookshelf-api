const express = require('express');
const bookController = require('../controllers/book');
const apiController = require('../controllers/api');

const router = express.Router();

router.route('/books')
    .get(bookController.allBooksList)
    .post(bookController.add)


router.route('/books/:id(\\d+)')
    .get(bookController.book);

router.use(apiController.resourceNotFound);


module.exports = router;