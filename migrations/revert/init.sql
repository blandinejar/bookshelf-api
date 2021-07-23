-- Revert bookshelf:init from pg


BEGIN;


DROP TABLE "book_has_author";

DROP TABLE "book_has_genre";

DROP TABLE "book";

DROP TABLE "genre";

DROP TABLE "author";

DROP TABLE "publisher";


DROP DOMAIN country_iso_code_2;

DROP DOMAIN isbn;

DROP DOMAIN url;

DROP DOMAIN pint;

COMMIT;
