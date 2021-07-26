-- Verify bookshelf:book_functions on pg

BEGIN;

SELECT id FROM get_book();
SELECT id FROM get_book(1);
SELECT id FROM insert_book('{
    "isbn": "9781234567891",
    "original_title": "the handmaid's tale",
    "title": "la servante écarlate",
    "excerpt": "la servante écarlate n'était pas bleue",
    "publication_date": 1985,
    "language": "FR",
    "page_count": 300,
    "cover": "http://www.google.fr/1.jpg",
    "publisher_id": 1
}');
SELECT id FROM update_book('{
    "id": 1,
    "isbn": "9781234567891",
    "original_title": "the handmaid's tale",
    "title": "la servante écarlate",
    "excerpt": "la servante écarlate n'était pas bleue",
    "publication_date": 1985,
    "language": "FR",
    "page_count": 300,
    "cover": "http://www.google.fr/1.jpg",
    "publisher_id": 1
}');
SELECT delete_book(input_id int);
ROLLBACK;
