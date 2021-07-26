const express = require('express');
const bookController = require('../controllers/book');
const apiController = require('../controllers/api');

const validate = require('../validations/validate');
const bookSchema = require('../validations/schemas/book');
const bookPatchSchema = require('../validations/schemas/bookPatch');

const router = express.Router();

router.route('/books')
    .get(bookController.allBooksList)
    .post(bookController.add)


router.route('/books/:id(\\d+)')
    .get(bookController.book)
    .patch(bookController.update)
    .put(bookController.update)
    .delete(bookController.delete);

router.use(apiController.resourceNotFound);


module.exports = router;