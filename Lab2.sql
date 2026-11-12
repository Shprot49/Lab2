-- 1) Все книги, выпущенные в 90-х годах, объёмом более 200 страниц
SELECT * FROM books WHERE year_of_publication BETWEEN 1990 AND 1999 AND number_of_pages > 200;

-- 2) Все отечественные авторы с фамилией на букву "В"
SELECT * FROM authors WHERE surname LIKE 'В%' AND nationality LIKE 'Русск%';

-- 3) Создать таблицу с данными 1 запроса с указанием авторов
SELECT b.book_id, b.autor_id, a.surname, a.first_name, a.patronymic,
b.title, b.year_of_publication, b.number_of_pages, b.publisher
INTO selected_books
FROM books b, authors a
WHERE a.autor_id = b.autor_id
AND b.year_of_publication BETWEEN 1990 AND 1999
AND b.number_of_pages > 200;

-- 4) Добавить в созданную таблицу книги, выпущенные в 80-х годах
INSERT INTO selected_books 
(book_id, autor_id, surname, first_name, patronymic, title, year_of_publication, number_of_pages, publisher)
SELECT b.book_id,
b.autor_id,
a.surname,
a.first_name,
a.patronymic,
b.title,
b.year_of_publication,
b.number_of_pages,
b.publisher
FROM books b
JOIN authors a ON a.autor_id = b.autor_id
WHERE b.year_of_publication BETWEEN 1980 AND 1989;

ALTER TABLE selected_books ADD PRIMARY KEY (book_id);


-- 5) В созданной таблице для всех книг 1995 года изменить год издания на 1996
UPDATE selected_books SET year_of_publication = 1996 WHERE year_of_publication = 1995;

-- 6) Удалить из созданной таблицы записи для всех книг, фамилии авторов которых начинаются на "А"
DELETE FROM selected_books WHERE surname LIKE 'А%';

-- 7) Сколько книг каждого автора хранится в библиотеке
SELECT a.autor_id, a.surname, a.first_name, COUNT(b.book_id) AS books_count FROM authors a
LEFT JOIN books b ON b.autor_id = a.autor_id
GROUP BY a.autor_id, a.surname, a.first_name
ORDER BY a.autor_id;

DROP TABLE IF EXISTS selected_books;