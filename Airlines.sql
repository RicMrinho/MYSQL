CREATE TABLE airlines (
  id INT AUTO_INCREMENT PRIMARY KEY,
  flight_code VARCHAR(10) NOT NULL,
  flight_name VARCHAR(100) NOT NULL,
  UNIQUE (flight_code),
  UNIQUE (flight_name)
);

CREATE TABLE available (
  id INT AUTO_INCREMENT PRIMARY KEY,
  flight_code VARCHAR(10) NOT NULL,
  flight_name VARCHAR(100) NOT NULL,
  flight_model VARCHAR(100) NOT NULL,
  date DATE NOT NULL,
  time TIME NOT NULL,
  from_location VARCHAR(50) NOT NULL,
  to_location VARCHAR(50) NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (flight_code) REFERENCES airlines(flight_code),
  FOREIGN KEY (flight_name) REFERENCES airlines(flight_name)
);



INSERT INTO airlines (flight_code, flight) VALUES
('GA', 'Garuda Indonesia'),
('JT', 'Lion Air'),
('AK', 'AirAsia'),
('QG', 'Citilink'),
('ID', 'Batik Air'),
('SJ', 'Sriwijaya Air'),
('IW', 'Wings Air'),
('IN', 'Nam Air'),
('XN', 'Xpress Air'),
('KD', 'Kalstar Aviation');

INSERT INTO available (flight_code, flight_name, flight_model, date, time, from_location, to_location, price)
SELECT
  airlines.flight_code,
  airlines.flight_name,
  plane.flight_model,
  dates.date,
  times.time,
  from_locations.from_location,
  to_locations.to_location,
  ROUND(RAND() * 1000 + 100, 2) -- Random price between 100 and 1100
FROM
  airlines,
  plane,
  (SELECT 'Jakarta (JKTA)' AS from_location UNION SELECT 'Tokyo (TYOA)' UNION SELECT 'Denpasar (DPS)' UNION SELECT 'Medan (KNO)') AS from_locations,
  (SELECT 'Jakarta (JKTA)' AS to_location UNION SELECT 'Tokyo (TYOA)' UNION SELECT 'Denpasar (DPS)' UNION SELECT 'Medan (KNO)') AS to_locations,
  (SELECT '2023-04-01' AS date UNION SELECT '2023-04-02' UNION SELECT '2023-04-03' UNION SELECT '2023-04-04' UNION SELECT '2023-04-05' UNION SELECT '2023-04-06') AS dates,
  (SELECT '08:00:00' AS time UNION SELECT '12:00:00' UNION SELECT '16:00:00' UNION SELECT '20:00:00') AS times
WHERE NOT EXISTS (
  SELECT 1
  FROM available
  WHERE available.flight_code = airlines.flight_code
    AND available.flight_name = airlines.flight_name
    AND available.flight_model = plane.flight_model
    AND available.date = dates.date
    AND available.time = times.time
    AND available.from_location = from_locations.from_location
    AND available.to_location = to_locations.to_location
)
ORDER BY RAND();



CREATE TABLE myticket (
  id INT AUTO_INCREMENT PRIMARY KEY,
  flight_code VARCHAR(10) NOT NULL,
  flight_name VARCHAR(100) NOT NULL,
  date DATE NOT NULL,
  from_location VARCHAR(50) NOT NULL,
  to_location VARCHAR(50) NOT NULL,
  amount INT NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (flight_code) REFERENCES airlines(flight_code),
  FOREIGN KEY (flight_name) REFERENCES airlines(flight_name),
);

CREATE TABLE register (
  email VARCHAR(255) PRIMARY KEY,
  full_name VARCHAR(255) NOT NULL,
  username VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL
);

CREATE TABLE pilot (
id INT AUTO_INCREMENT PRIMARY KEY,
pilot_name VARCHAR(100) NOT NULL
);


CREATE TABLE plane (
id INT AUTO_INCREMENT PRIMARY KEY,
flight_model VARCHAR(100) NOT NULL
);

INSERT INTO Destination (City, Code) VALUES
('Jakarta', 'CGK'),
('Surabaya', 'SUB'),
('Bali', 'DPS'),
('Medan', 'KNO'),
('Yogyakarta', 'JOG'),
('Makassar', 'UPG'),
('Bandung', 'BDO'),
('Semarang', 'SRG'),
('Palembang', 'PLM');

INSERT INTO Plane (Flight_Model) VALUES
('Boeing 737'),
('Airbus A320'),
('ATR 72'),
('Boeing 777'),
('Airbus A330'),
('Embraer E190'),
('Boeing 747'),
('Airbus A350'),
('Bombardier CRJ900');
