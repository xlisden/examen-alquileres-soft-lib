CREATE TABLE edificios (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nro_departamentos INT NOT NULL,
  direccion VARCHAR(100) NOT NULL,
  nro_pisos INT NOT NULL DEFAULT 1
);

INSERT INTO edificios (nro_departamentos, direccion, nro_pisos)
VALUES (3, 'direccion1', 3), (4, 'direccion2', 2), (6, 'direccion3', 3);
-- verificar nro de pisos en insercion departamentos

CREATE TABLE departamentos (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nro INT NOT NULL,
	piso INT NOT NULL,
	area VARCHAR(20) NOT NULL,
	nro_habitaciones INT NOT NULL DEFAULT 1,
	edificio_id INT NOT NULL,	
	CONSTRAINT fk_departamentos_edificio FOREIGN KEY (edificio_id) REFERENCES edificios(id)
);

INSERT INTO departamentos (nro, piso, area, nro_habitaciones, edificio_id)
VALUES
			(11, 1, 'area1', 4, 1), (12, 3, 'area3', 2, 1), (13, 3, 'area2', 3, 1),
			(21, 1, 'area2', 2, 2), (22, 1, 'area1', 2, 2), (23, 2, 'area2', 2, 2), (24, 2, 'area2', 2, 2),
			(31, 1, 'area3', 2, 3), (32, 1, 'area2', 3, 3), (32, 3, 'area3', 4, 3);

CREATE TABLE inquilinos (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  dni VARCHAR(8) NOT NULL DEFAULT '00000000',  
  nombres VARCHAR(100) NOT NULL,
  ap_paterno VARCHAR(50) NOT NULL,
  ap_materno VARCHAR(50),
  fecha_nacimiento DATE,
	direccion VARCHAR(200),
	correo VARCHAR(100) NOT NULL
);

INSERT INTO inquilinos(dni, nombres, ap_paterno, ap_materno, fecha_nacimiento, direccion, correo)
VALUES 
			('1110111', 'nombre1', 'ap_paterno1', 'ap_materno1', '2000-01-21', NULL, 'correo1@gmail.com'), ('1110222', 'nombre2', 'ap_paterno2', NULL, '2000-02-22', NULL, 'correo2@gmail.com'),
			('2220111', 'nombre3', 'ap_paterno3', 'ap_materno3', '2033-01-20', 'direccion_inq_1', 'correo3@gmail.com'), ('2220222', 'nombre4', 'ap_paterno4', 'ap_materno4', NULL, NULL, 'correo4@gmail.com'),
			('3330111', 'nombre5', 'ap_paterno5', 'ap_materno5', NULL, NULL, 'correo5@gmail.com'), ('3330222', 'nombre6', 'ap_paterno6', NULL, '2006-06-06', NULL, 'correo6@gmail.com');

CREATE TABLE alquileres (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	departamento_id INT NOT NULL,
	inquilino_id INT NOT NULL,
	CONSTRAINT fk_alquileres_departamento FOREIGN KEY (departamento_id) REFERENCES departamentos(id),
	CONSTRAINT fk_alquileres_inquilino FOREIGN KEY (inquilino_id) REFERENCES inquilinos(id)
);

INSERT INTO alquileres (departamento_id, inquilino_id)
VALUES
			(1, 6), (2, 5), (4, 4), (5, 3), (8, 2), (9, 1);

CREATE TABLE pagos_alquileres (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  mes INT NOT NULL,
  anio INT NOT NULL,
	alquiler_id INT NOT NULL,
	monto DECIMAL(10, 2) NOT NULL,
	CONSTRAINT fk_pagos_alquileres_alquiler FOREIGN KEY (alquiler_id) REFERENCES alquileres(id)
);

INSERT INTO pagos_alquileres (mes, anio, alquiler_id, monto)
VALUES
			(10, 2024, 1, 1100), (11, 2024, 1, 1100), (06, 2025, 1, 1100),
			(06, 2025, 2, 2200), (07, 2025, 2, 2200), (08, 2025, 2, 2200),
			(04, 2025, 3, 3300), (05, 2023, 3, 3300), (06, 2023, 3, 3300),
			(08, 2025, 4, 4400),
			(07, 2024, 5, 5500), (10, 2025, 5, 5500),
			(08, 2025, 6, 6600), (09, 2025, 6, 6600), (10, 2025, 6, 6600);

-- SELECT DATE_FORMAT('2025-10-25', '%d');

SELECT DISTINCT d.nro, d.piso, d.area, d.nro_habitaciones, d.edificio_id, CONCAT(i.nombres, ' ', i.ap_paterno) AS inquilino
FROM departamentos d
LEFT JOIN alquileres a ON a.departamento_id = d.id
LEFT JOIN inquilinos i ON i.id = a.inquilino_id
WHERE d.edificio_id = 2
;

SELECT DISTINCT
  d.nro, 
  d.piso, 
  d.area, 
  d.nro_habitaciones, 
  d.edificio_id,
  CONCAT(i.nombres, ' ', i.ap_paterno) AS inquilino
FROM departamentos d
LEFT JOIN alquileres a ON a.departamento_id = d.id
LEFT JOIN inquilinos i ON i.id = a.inquilino_id
WHERE d.edificio_id = 2
GROUP BY d.id, d.nro, d.piso, d.area, d.nro_habitaciones, d.edificio_id
;


SELECT DISTINCT  i.nombres, i.ap_paterno
FROM inquilinos i 
INNER JOIN alquileres a ON a.inquilino_id = i.id
WHERE a.departamento_id  = 3
;

SELECT CONCAT(i.nombres, ' ', i.ap_paterno) AS inquilino 
FROM inquilinos i  
INNER JOIN alquileres a ON a.inquilino_id = i.id 
WHERE a.departamento_id  = 2
ORDER BY a.id DESC LIMIT 1
;

SELECT id, nro, piso, area, nro_habitaciones 
FROM departamentos WHERE edificio_id = 1;






