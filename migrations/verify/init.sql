-- Verify bookshelf:init on pg

BEGIN;

SELECT id FROM book WHERE false;
SELECT id FROM genre WHERE false;
SELECT id FROM author WHERE false;
SELECT id FROM publisher WHERE false;

SELECT book.id 
FROM book 
JOIN publisher ON book.publisher_id = publisher.id
JOIN book_has_genre ON book_has_genre.book_id = book.id
JOIN genre ON book_has_genre.genre_id = genre.id
JOIN book_has_author ON book_has_author.book_id = book.id
JOIN author ON book_has_author.author_id = author.id
WHERE FALSE;

ROLLBACK;
