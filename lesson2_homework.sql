USE studies
GO
if OBJECT_ID('ls2.main_list')is not null drop table ls2.main_list 

create table ls2.main_list(
	personid int not null identity constraint pk_main_list primary key,
	ФИО VARCHAR (50) NOT NULL, 
	ДР DATE NOT NULL, 
	Статус VARCHAR (15) CONSTRAINT ck_status CHECK (Статус IN ('женат', 'холост')), 
	Тел CHAR(3) NOT NULL,
	Комментарий VARCHAR (255) NOT NULL,
	Адрес VARCHAR (50) NOT NULL,
	Группа VARCHAR (15) NOT NULL
)

INSERT ls2.main_list ( ФИО, ДР, Статус, Тел, Комментарий, Адрес, Группа) VALUES ('Иванов И. И.', '19900212', 'женат', '126', 'интернет', 'Можга', 'Работа'),  ('Иванов И. И.', '19900212', 'женат', '127', 'старый', 'Можга', 'Работа'),  ('Иванов И. И.', '20010918', 'холост', '527', 'личный', 'Санкт-Петербург', 'Школа'),  ('Петров П. П.', '19830423', 'женат', '234', 'личный', 'Москва', 'Родня'),  ('Петров П. П.', '19830424', 'женат', '235', 'рабочий', 'Москва', 'Родня'),  ('Васильев В. В.', '19980521', 'холост', '456', 'личный', 'Белгород', 'Друзья'),  ('Сидоров С.С.', '20070713', 'холост', '643', 'личный', 'Киров', 'Родня'),  ('Сидоров С.С.', '20070713', 'холост', '654', 'старый', 'Киров', 'Родня'),  ('Александров А.А.', '19870305', 'женат', '412', 'рабочий', 'Уфа', 'Друзья'),  ('Борисов Б.Б', '19890816', 'холост', '723', 'рабочий', 'Москва', 'Работа'),  ('Михайлов М.М.', '19970108', 'женат', '876', 'личный', 'Сочи', 'Университет'),  ('Михайлов М.М.', '19970108', 'женат', '875', 'рабочий', 'Сочи', 'Университет'),  ('Кириллов К.К.', '19961203', 'холост', '933', 'личный', 'Киров', 'Работа')
SELECT * FROM ls2.main_list ос
SELECT ФИО, Тел, Комментарий FROM ls2.main_list ml
SELECT ФИО, Тел, Комментарий FROM ls2.main_list ml WHERE Группа = 'Родня'
SELECT Тел FROM ls2.main_list ml WHERE Группа = 'Друзья' AND Статус = 'холост'
SELECT FORMAT(ДР, 'dd.MM.yyyy') ДР FROM ls2.main_list ml  WHERE Группа = 'Университет' OR Статус = 'холост'

if OBJECT_ID('ls2.addresses')is not null drop table ls2.addresses
if OBJECT_ID('ls2.phones')is not null drop table ls2.phones
if OBJECT_ID('ls2.People')is not null drop table ls2.People 

create table ls2.People(
	id int not null constraint pk_People primary key,
	ФИО VARCHAR (50) NOT NULL, 
	ДР DATE NOT NULL, 
	Статус VARCHAR (15) CONSTRAINT ck_status2 CHECK (Статус IN ('женат', 'холост')) 

)
INSERT ls2.People (id, ФИО, ДР, Статус) VALUES (1,   'Иванов И. И.', '19900212', 'женат'), (2,   'Иванов И. И.', '20010918', 'холост'), (3,   'Петров П. П.', '19830423', 'женат'), (4,   'Васильев В. В.', '19980521', 'холост'), (25,   'Кузьмин К.К.', '20200521', 'холост')
SELECT * FROM ls2.People p


create table ls2.phones(
	id int not null,
	ТЕЛ CHAR (3) NOT NULL, 
	Коммент VARCHAR(15) NOT NULL, 
	CONSTRAINT pk_phones PRIMARY KEY (id, ТЕЛ)
)
INSERT ls2.phones (id, Тел, Коммент) VALUES (1,   '123', 'личный'), (1,   '124', 'рабочий'), (1,   '125', 'для поездок'), (1,   '126', 'интернет'), (1,   '127', 'старый'), (2,   '527', 'личный'), (3,   '234', 'личный'), (3,   '235', 'рабочий'), (4,   '456', 'личный'), (11,   '999', 'личный'), (12,   '997', 'рабочий'), (13,   '995', 'личный'), (14,   '993', 'для поездок'), (15,   '991', 'для поездок')
SELECT * FROM ls2.phones p

SELECT * FROM ls2.People p  INNER JOIN   ls2.phones h ON  P.id = h.id
SELECT * FROM ls2.People p  LEFT JOIN   ls2.phones h ON  P.id = h.id
SELECT * FROM ls2.People p  RIGHT JOIN   ls2.phones h ON  P.id = h.id
SELECT * FROM ls2.People p  FULL JOIN   ls2.phones h ON  P.id = h.id
SELECT ФИО, Тел, Коммент FROM ls2.People p LEFT JOIN ls2.phones p1 ON p.id = p1.id

create table ls2.addresses(
	id int not null,
	Адрес varCHAR (25) NOT NULL, 
	Коммент VARCHAR(15) NOT NULL
)
INSERT ls2.addresses (id, Адрес, Коммент) VALUES (1,   'Можга', 'Место рождения'), (1,   'Казань', 'По прописке'), (1,   'Москва', 'Рабочий'), (2,   'Санкт-Петербург', 'По прописке'), (3,   'Москва', 'По прописке'), (4,   'Белгород', 'По прописке'), (5,   'Уфа', 'По прописке'), (6,   'Сочи', 'По прописке'), (7,   'Киров', 'Рабочий'), (8,   'Владивосток', 'Место рождения'), (9,   'Рязань', 'Рабочий'), (10,   'Хабаровск', 'Место рождения')
SELECT * FROM ls2.addresses a
SELECT ФИО, Адрес, Коммент FROM ls2.People p RIGHT JOIN ls2.addresses a ON p.id = a.id