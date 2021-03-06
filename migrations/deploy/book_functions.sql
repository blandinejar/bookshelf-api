-- Deploy bookshelf:book_functions to pg

BEGIN;

-- récupérer tous les livres
-- cette fonction va renvoyer plusieurs enregistrements de type book
-- un set d'enreigstrement
-- et en plus on peut se servir de la vue précédemment créée qui a elle aussi son type d'enregistremnet

CREATE FUNCTION get_book() RETURNS SETOF book_with_genre_and_author AS $$
    SELECT * FROM book_with_genre_and_author;
$$ LANGUAGE SQL;

-- récupérer un livre
-- le mot-clé strict permet de ne même pas exécuter les instructions de la fonction si jamais les arguments fournis ne correspondent pas aux paramètres définis
-- il renvoie null directement, sous la forme du type de retour
CREATE FUNCTION get_book(input_id INT) RETURNS book_with_genre_and_author AS $$
    SELECT * FROM book_with_genre_and_author WHERE id = input_id;
$$ LANGUAGE SQL STRICT;
-- dans l'appli, on vérifie si le retour est null ou pas, pour savoir si cela s'est bien passé

-- ajouter un livre
CREATE OR REPLACE FUNCTION insert_book(book json) RETURNS book AS $$
INSERT INTO book
(
    "isbn",
    "original_title",
    "title",
    "excerpt",
    "publication_date",
    "language",
    "page_count",
    "cover",
    "publisher_id"
) VALUES
(
    book->>'isbn',
    book->>'original_title',
    book->>'title',
    book->>'excerpt',
    (book->>'publication_date')::int,
    book->>'language',
    (book->>'page_count')::int,
    book->>'cover',
    (book->>'publisher_id')::int
)

RETURNING *
$$ LANGUAGE SQL STRICT;

-- CREATE FUNCTION insert_book(book) RETURNS book AS $$
--     INSERT INTO book
--     (isbn, original_title, title, excerpt, publication_date, language, page_count, cover, publisher_id, created_at, updated_at)
--     VALUES ($1.isbn, $1.original_title, $1.title, $1.excerpt, $1.publication_date, $1.language, $1.page_count, $1.cover, $1.publisher_id, $1.created_at, $1.updated_at) RETURNING *;
-- $$ LANGUAGE SQL;

-- SELECT * FROM insert_book((
--     null,
--     '9781234567891',
--     'the handmaid''s tale',
--     'la servante écarlate',
--     'la servante écarlate n''était pas bleue',
--     1985,
--     'FR',
--     300,
--     'http://image.cover.come/tale.jpg',
--     1,
--     now(),
--     null
-- ))::book


-- modifier un livre
CREATE FUNCTION update_book(bookInput json) RETURNS book AS $$
UPDATE book
SET
    "isbn" = bookInput->>'isbn',
    "original_title" = bookInput->>'original_title',
    "title" = bookInput->>'title',
    "excerpt" = bookInput->>'excerpt',
    "publication_date" = (bookInput->>'publication_date')::int,
    "language" = bookInput->>'language',
    "page_count" = (bookInput->>'page_count')::int,
    "cover" = bookInput->>'cover',
    "publisher_id" = (bookInput->>'publisher_id')::int
    WHERE id = (bookInput->>'id')::int

RETURNING *
$$ LANGUAGE SQL STRICT;


-- supprimer un livre
-- cas particulier du delete, il ne renvoie rien, mais une fonction en SQL doit toujours renvoyer quelque chose. Ici, on renvoie du néant pour "hacker" la contrainte
CREATE FUNCTION delete_book(input_id int) RETURNS void AS $$
DELETE FROM book WHERE id = input_id;
$$ LANGUAGE SQL;

COMMIT;
