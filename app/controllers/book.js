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
            response.status(500).json({ data: [], error: `A server error occurred, please try again later` });
        }
    },

    /**
     * Get one book by its id
     * @param {object} request express request
     * @param {object} response express response
     * @param {object} next next
     */
    async book(request, response, next) {
        try {
            const bookId = request.params.id;
            
            const book = await BookModel.findOne(bookId);
            if(!book){
                return next;
            }
            response.json({ data: {book} })
            
        } catch (error) {
            console.error(error);
            response.status(500).json({ data: [], error: `A server error occurred, please try again later` });
        }
    },

    /**
     * Add book
     * @param {object} request express request
     * @param {object} response express response
     * @param {object} next next
     */
     async add(request, response, next) {
        try {
            const newBook = new BookModel(request.body);

            const book = await newBook.save();
            // dans le cas d'une insertion, afin d'être le plus précis possible, on utilise le code 201 created
            response.status(201).json({ data: {book} })
        } catch (error) {
            console.error(error);
            // dans le cas d'une erreur serveur, on renvoie le code générique 500 internal server error
            response.status(500).json({ data: [], error: `A server error occurred, please try again later` });
        }
    },

    async update(request, response, next){
        try {
            const book = await BookModel.findOne(request.params.id);
            if(!book){
                return next;
            }
            book.setData(request.body);

            // comme save renvoie l'instance, on peut "chaîner" les méthodes de l'active record
            // const updatedBook = await book.save().findOne(book.id);
            // ! par contre, attention : findOne est une méthode static, et on ne peut pas utiliser une méthode static sur une instance. Donc on ne peut pas faire cela 

            await book.save();
            response.json({ data: book });

        } catch (error) {
            console.error(error);
            response.status(500).json({ data: [], error: `A server error occurred, please try again later` });
        }
    },

    async delete(request, response, next){
        try {
            const book = await BookModel.findOne(request.params.id);
            if (!book){
                return next();
            }
            await book.delete();
            // dans le cas d'une suppression, on ne peut rien renvoyer, donc on précise qu'il n'y a pas de contenu. Du côté du front, afin de savoir si la suppression s'est bien déroulée, il suffira de tester le code http de retour
            response.status(204).json();
        } catch (error) {
            console.error(error);
            response.status(500).json({ data: [], error: `A server error occurred, please try again later` });
        }
        
    }

    

}

module.exports = bookController;