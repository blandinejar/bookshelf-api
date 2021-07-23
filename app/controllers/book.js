const { BookModel } = require('../models');

const bookController = {

    /**
     * Get list of all books
     * @param {object} _ express request not used
     * @param {object} response express response
     */
    async allBooksList(_, response) {
        try {
        const books = await BookModel.find();
        response.json({ data: [books] });
        } catch (error) {
            console.error(error);
            response.json({ data: [], error: `A server error occurred, please try again later` });
        }
    },

    /**
     * Get one book by its id
     * @param {object} request express request
     * @param {object} response express response
     * @param {object} next next
     */
    book(request, response, next) {
        try {
            const bookId = request.params.id;
            response.json({ data: {} })
        } catch (error) {
            console.error(error);
            response.json({ data: [], error: `A server error occurred, please try again later` });
        }
    }

}

module.exports = bookController;