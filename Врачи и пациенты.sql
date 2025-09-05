CREATE table doctors (doctor_id INTEGER PRIMARY KEY, first_name VARCHAR (30),
                      last_name VARCHAR (30), specialty VARCHAR (25));  
INSERT INTO doctors (doctor_id, first_name, last_name, specialty)
	VALUES (1, 'Ольга', 'Смирнова', 'стоматолог-ортодонт'),
    (2, 'Семен','Лапников', 'хирург'),
    (3, 'Эдуард','Иваненко', 'кардиолог'),
    (4, 'Лилия','Иванова', 'реаниматолог'),
    (5, 'Валентина','Жербина', 'терапевт'),
    (6, 'Артем','Жданов', 'невролог');

CREATE table province_names (province_id CHAR(2) PRIMARY KEY, province_name VARCHAR (30));
INSERT INTO province_names (province_id, province_name)                     
	VALUES ('SP', 'Санкт-Петербург'),
    ('MC', 'Москва'),
    ('EK', 'Екатеринбург'),
    ('KR', 'Краснодар'),
    ('OM', 'Омск');

CREATE table patients (patient_id INTEGER PRIMARY KEY, first_name VARCHAR(30), last_name VARCHAR(30),
                       gender CHAR(1), birth_date DATE, city VARCHAR(30), 
                       province_id CHAR(2),
                       allergies VARCHAR(80), height DECIMAL (3,0), weight DECIMAL (4,0), 
                       FOREIGN KEY (province_id) REFERENCES province_names (province_id));
INSERT INTO patients (patient_id, first_name, last_name, gender, birth_date, city, province_id,
                      allergies, height, weight)                     
	VALUES ('1', 'Илья', 'Смирнов', 'М', '2003-12-09', 'Вологда', 'KR', 'плесень', 182, 78),
    ('2', 'Владислав', 'Петров', 'М', '1999-02-13', 'СПб', 'SP', 'клубника', 178, 89),
    ('3', 'Марина', 'Спиридонова', 'Ж', '1989-14-11', 'Москва', 'KR', 'пыль', 167, 63),
    ('4', 'Кузьма', 'Скоробогатов', 'М', '2013-08-01', 'Волгоград', 'MC', '-', 160, 57);
    
CREATE table admissions (patient_id INT, admission_data DATE, discharge_date DATE,
                        diagnosis VARCHAR(50), attending_doctor_id INT,
                        FOREIGN KEY (patient_id) REFERENCES patients (patient_id),
                        FOREIGN KEY (attending_doctor_id) REFERENCES doctors (doctor_id));
INSERT INTO admissions (patient_id, admission_data, discharge_date, diagnosis, attending_doctor_id)
	VALUES (1, '2022-12-09', '2022-12-09', 'перелом','2'),
    (2, '2022-12-12','2022-12-13', 'ОРВИ', '5'),
    (3, '2024-12-12','2024-12-13', 'коронавирус', '5'),
    (4, '2024-12-12','2024-12-13', 'кариес 7-ки', '1');
    
SELECT * FROM doctors
SELECT * FROM province_names
SELECT * FROM patients
SELECT * FROM admissions

Задача: составь запрос, который выведет фамилию, имя и количество посещений каждого доктора. 
Все пациенты были осмотрены докторами. 
Всего в базе 4 пациента, двое из них были осмотрены терапевтом, один хирургом и еще 
один стоматологом-ортодонтом. Докторов 6, двое докторов не задействованы.

SELECT first_name, last_name, COUNT (attending_doctor_id) AS number_of_visits 
FROM doctors LEFT JOIN admitions ON doctor_id = attending_doctor_id
GROUP BY first_name, last_name;


