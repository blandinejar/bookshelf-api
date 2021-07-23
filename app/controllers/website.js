module.exports = {

    homePage(_, response) {
        response.render('home')
    },

    pageNotFound(_, response) {
        response.status(404).render('error', {message: `404 page not found`})
    }

}