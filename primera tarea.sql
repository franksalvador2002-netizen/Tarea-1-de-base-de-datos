create database sistema_bancario;
use sistema_bancario;

/*
tabla de clientes
*/
create table clientes ( id int auto_increment primary key,
nombres varchar(255),
apellidos varchar(255),
telefono varchar(255),
direccion varchar(255));

/*tabla de cuentas*/
create table cuentas ( id int auto_increment primary key,
id_cliente int, tipo enum('ahorro', 'corriente'),
numero bigint, balance float, FOREIGN KEY (id_cliente) REFERENCES clientes(id));

/*tabla de transacciones*/
create table transacciones( id int auto_increment primary key,
id_cuenta int, fecha_hora datetime, tipo enum('deposito', 'retiro'),
monto float, foreign key(id_cuenta) references cuentas(id));

/*
 tabla de tarjetas
*/
create table tarjetas( id int auto_increment primary key,
tipo enum('debito', 'credito'), id_cliente int, numero bigint,
limite float, foreign key(id_cliente) references clientes(id));

/* 
tabla prestamos
*/
create table prestamos( id int auto_increment primary key,
id_cliente int, monto float, tasa float, plazo date, 
estado enum('activo', 'pagado', 'vencido'), foreign key(id_cliente) references clientes(id));

/*
tabla inversiones
*/
create table inversiones( id int auto_increment primary key,
id_cliente int, tipo enum('acciones', 'bonos', 'fondos'),
monto float, fecha date, valor_actual float, foreign key(id_cliente) references clientes(id));

/*
taba transferencias
*/
create table transferencias( id int auto_increment primary key,
origen int, destino int, fecha_hora datetime,
monto float, foreign key(origen) references cuentas(id),
foreign key(destino) references cuentas(id));

INSERT INTO clientes (nombres, apellidos, telefono, direccion) VALUES
('Juan', 'Perez', '999111222', 'Lima'),('Maria', 'Gomez', '988777666', 'Arequipa'),
('Luis', 'Torres', '977555444', 'Cusco'),('Ana', 'Lopez', '966333222', 'Piura'),
('Carlos', 'Ramos', '955222111', 'Trujillo');

INSERT INTO cuentas (id_cliente, tipo, numero, balance) VALUES
(1, 'ahorro', 111111, 15000),(1, 'corriente', 111112, 5000),(2, 'ahorro', 222222, 20000),
(3, 'corriente', 333333, 800),(4, 'ahorro', 444444, 12000);

INSERT INTO transacciones (id_cuenta, fecha_hora, tipo, monto) VALUES
(1, NOW() - INTERVAL 10 DAY, 'deposito', 5000),(1, NOW() - INTERVAL 5 DAY, 'retiro', 2000),
(2, NOW() - INTERVAL 2 DAY, 'deposito', 3000),(3, NOW() - INTERVAL 40 DAY, 'retiro', 1000),
(4, NOW() - INTERVAL 1 DAY, 'deposito', 700),(1, NOW(), 'retiro', 1000);

INSERT INTO tarjetas (tipo, id_cliente, numero, limite) VALUES
('credito', 1, 999001, 10000),('debito', 2, 999002, 5000),('credito', 3, 999003, 7000);

INSERT INTO prestamos (id_cliente, monto, tasa, plazo, estado) VALUES
(1, 10000, 5.5, '2026-12-31', 'activo'),(2, 5000, 4.0, '2025-10-10', 'pagado'),
(3, 2000, 6.0, '2026-06-01', 'activo'),(4, 15000, 7.0, '2027-01-01', 'vencido');

INSERT INTO inversiones (id_cliente, tipo, monto, fecha, valor_actual) VALUES
(1, 'acciones', 6000, '2025-01-01', 8000),(2, 'bonos', 3000, '2025-03-01', 3200),
(3, 'fondos', 7000, '2025-02-01', 6500),(4, 'acciones', 10000, '2025-04-01', 15000);

INSERT INTO transferencias (origen, destino, fecha_hora, monto) VALUES
(1, 2, NOW() - INTERVAL 1 DAY, 500),(1, 3, NOW() - INTERVAL 1 DAY, 300),
(1, 4, NOW() - INTERVAL 1 DAY, 200),(2, 1, NOW() - INTERVAL 2 DAY, 1000),
(3, 1, NOW() - INTERVAL 3 DAY, 400);


select * from clientes;
select * from cuentas;
select * from transacciones;
select * from tarjetas;
select * from prestamos;
select * from inversiones;
select * from transferencias;
-- lista todos los clientes con al menos una cuenta
select distinct clientes. * from clientes inner join cuentas on clientes.id = cuentas.id_cliente;

-- mostrar el saldo total por cliente
select clientes.nombres, sum(cuentas.balance) as saldo_total
from clientes inner join cuentas on clientes.id = cuentas.id_cliente
group by clientes.id, clientes.nombres;

-- obtener todas las transacciones de un cliente especifico
select transacciones. * from transacciones inner join cuentas on transacciones.id_cuenta
= cuentas.id   where cuentas.id_cliente = 1;

-- cuentas con saldo mayor a 10 000
select * from cuentas where balance > 10000;

-- clientes que tienen tarjetas
select clientes. * from clientes inner join tarjetas on clientes.id = tarjetas.id_cliente;

-- numero de cuentas por cliente
select clientes.nombres, count(cuentas.id) as total_cuentas
from clientes left join cuentas on clientes.id = cuentas.id_cliente
group by clientes.id,clientes.nombres;

-- listar los prestamos activos
select * from prestamos where estado = 'activo';

-- muestra el monto total transferido desde cada cuenta
select origen, sum(monto) as total_transferido
from transferencias group by origen;

-- obtener las transacciones del ultimo mes
select * from transacciones where fecha_hora >= now() - interval 1 month;

-- muestra clientes con inversiones mayores a 5000 soles
select distinct clientes. * from clientes inner join inversiones on clientes.id 
= inversiones.id_cliente where inversiones.monto > 5000;

-- muestra nombre de cliente + numero de cuenta + saldo
select clientes.nombres, cuentas.numero, cuentas.balance from clientes inner join cuentas on clientes.id = cuentas.id_cliente;

-- obtener el total de transacciones por cuenta
select id_cuenta, count(*) as total_transacciones 
from transacciones group by id_cuenta;

-- listar clientes sin cuentas 
select clientes. * from clientes left join cuentas on clientes.id
= cuentas.id_cliente where cuentas.id is null;

-- muestra el cliente con mas cuentas
SELECT clientes.nombres, COUNT(cuentas.id) AS total_cuentas
FROM clientes 
INNER JOIN cuentas  ON clientes.id = cuentas.id_cliente
GROUP BY clientes.id, clientes.nombres
ORDER BY total_cuentas DESC
LIMIT 1;

-- obtener el total de prestamos por cliente
SELECT clientes.nombres, COUNT(prestamos.id) AS total_prestamos
FROM clientes 
LEFT JOIN prestamos ON clientes.id = prestamos.id_cliente
GROUP BY clientes.id, clientes.nombres;

-- mostrar el total invertido por cliente
SELECT clientes.nombres, SUM(inversiones.monto) AS total_invertido
FROM clientes 
INNER JOIN inversiones ON clientes.id = inversiones.id_cliente
GROUP BY clientes.id, clientes.nombres;

-- cuentas que nunca han tenido transacciones
SELECT cuentas. *
FROM cuentas 
LEFT JOIN transacciones ON cuentas.id = transacciones.id_cuenta
WHERE transacciones.id IS NULL;

-- obtener promedio de monto por transaccion
SELECT AVG(monto) AS promedio_transacciones
FROM transacciones;

-- mostrar los cinco clientes con mayor monto total
SELECT clientes.nombres, SUM(cuentas.balance) AS saldo_total
FROM clientes 
INNER JOIN cuentas ON clientes.id = cuentas.id_cliente
GROUP BY clientes.id, clientes.nombres
ORDER BY saldo_total DESC
LIMIT 5;

-- listar clientes que tienen cuentas y prestamos
SELECT DISTINCT clientes. *
FROM clientes 
INNER JOIN cuentas ON clientes.id = cuentas.id_cliente
INNER JOIN prestamos ON clientes.id = prestamos.id_cliente;

-- obtener el cliente con mayor actividad
SELECT clientes.nombres, COUNT(transacciones.id) AS total_transacciones
FROM clientes 
INNER JOIN cuentas ON clientes.id = cuentas.id_cliente
INNER JOIN transacciones ON cuentas.id = transacciones.id_cuenta
GROUP BY clientes.id, clientes.nombres
ORDER BY total_transacciones DESC
LIMIT 1;

-- detectar cuentas con transferencias sospechosas
SELECT origen, DATE(fecha_hora) AS fecha, COUNT(*) AS total
FROM transferencias
GROUP BY origen, DATE(fecha_hora)
HAVING COUNT(*) > 3;

-- listar clientes cuyo saldo total es menor a sus préstamos
SELECT clientes.nombres, 
       SUM(cuentas.balance) AS total_saldo, 
       SUM(prestamos.monto) AS total_prestamos
FROM clientes 
INNER JOIN cuentas ON clientes.id = cuentas.id_cliente
INNER JOIN prestamos ON clientes.id = prestamos.id_cliente
GROUP BY clientes.id, clientes.nombres
HAVING total_saldo < total_prestamos;

-- ranking de clientes por inversiones
SELECT clientes.nombres,
       SUM(inversiones.monto) AS total_inversion,
       RANK() OVER (ORDER BY SUM(inversiones.monto) DESC) AS ranking
FROM clientes
INNER JOIN inversiones ON clientes.id = inversiones.id_cliente
GROUP BY clientes.id, clientes.nombres;

-- mostrar  crecimiento de inversiones
SELECT clientes.nombres,
       inversiones.monto,
       inversiones.valor_actual,
       (inversiones.valor_actual - inversiones.monto) AS ganancia
FROM clientes
INNER JOIN inversiones ON clientes.id = inversiones.id_cliente;
