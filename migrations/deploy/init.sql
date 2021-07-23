-- Deploy bookshelf:init to pg

BEGIN;

CREATE DOMAIN country_iso_code_2 AS text
CHECK (VALUE ~ '^[A-Z]{2}$');
COMMENT ON DOMAIN country_iso_code_2 IS 'check if the country matches with the rule ISO 3166-1 alpha-1';

CREATE DOMAIN isbn AS text
CHECK (VALUE ~ '^(?=(?:\D*\d){10}(?:(?:\D*\d){3})?$)[\d-]+$');
COMMENT ON DOMAIN isbn IS 'check if isbn is valid';

CREATE DOMAIN url AS text
CHECK (VALUE ~ '^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#()?&//=]*)$');
COMMENT ON DOMAIN url IS 'check if it is a distant or local url';

CREATE DOMAIN pint AS int
CHECK (VALUE >= 0);
COMMENT ON DOMAIN pint IS 'only positive integer is accepted';



CREATE TABLE "publisher" (
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "name" text NOT NULL UNIQUE,
    "country" country_iso_code_2 NOT NULL,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
    "updated_at" TIMESTAMPTZ
);


CREATE TABLE "author" (
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "first_name" text NOT NULL,
    "last_name" text NOT NULL,
    "nationality" country_iso_code_2 NOT NULL,
    "birth_date" date NOT NULL,
    "death_date" date,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
    "updated_at" TIMESTAMPTZ,
    UNIQUE ("first_name", "last_name", "nationality", "birth_date")
);


CREATE TABLE "genre" (
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "label" text NOT NULL UNIQUE,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
    "updated_at" TIMESTAMPTZ
);


CREATE TABLE "book" (
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "isbn" isbn NOT NULL,
    "original_title" text NOT NULL,
    "title" text,
    "excerpt" text,
    "publication_date" date,
    "language" country_iso_code_2 NOT NULL,
    "page_count" pint NOT NULL,
    "cover" url,
    "publisher_id" int NOT NULL REFERENCES "publisher"("id"),
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
    "updated_at" TIMESTAMPTZ
);


CREATE TABLE "book_has_author" (
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "book_id" int NOT NULL REFERENCES "book"("id"),
    "author_id" int NOT NULL REFERENCES "author"("id"),
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE ("book_id", "author_id")
    
);

CREATE TABLE "book_has_genre" (
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "book_id" int NOT NULL REFERENCES "book"("id"),
    "genre_id" int NOT NULL REFERENCES "genre"("id"),
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE ("book_id", "genre_id")
);

COMMIT;
