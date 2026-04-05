# Primera consulta: clientes con al menos una cuenta

```
Primero se toma la tabla de clientes como base.
Luego se realiza una unión con la tabla de cuentas utilizando el identificador del cliente.
Esta unión es de tipo INNER JOIN, por lo que solo se consideran los clientes que tienen al menos una cuenta.
Finalmente, se eliminan los registros duplicados porque un cliente puede tener varias cuentas.

 Resultado: se obtienen únicamente los clientes que poseen cuentas.

 select distinct clientes. *
  from clientes inner join cuentas on
  clientes.id = cuentas.id_cliente;
```

# Segunda Consulta: Saldo total por cliente

```
Primero se relaciona la tabla de clientes con la tabla de cuentas.
Luego se toma el saldo de cada cuenta asociada a un cliente.
Después se suman todos esos saldos utilizando una función de agregación.
Finalmente, se agrupan los resultados por cliente para obtener un único total por cada uno.

 Resultado: cada cliente muestra su saldo total acumulado.

 select clientes.nombres, sum(cuentas.balance) as saldo_total
from clientes inner join cuentas on clientes.id = cuentas.id_cliente
group by clientes.id, clientes.nombres;
```

# Tercera Consulta: Transacciones de un cliente especifico

```
Primero se parte de la tabla de transacciones.
Luego se relaciona con la tabla de cuentas para identificar a qué cliente pertenece cada transacción.
Después se filtra por un cliente específico utilizando su identificador.
De esta manera se obtienen únicamente las transacciones de ese cliente.

 Resultado: historial completo de movimientos de un cliente.

 select transacciones. * from transacciones inner join cuentas on transacciones.id_cuenta
= cuentas.id   where cuentas.id_cliente = 1;
```

# Cuarta Consulta: Cuentas con saldo mayor a 10000

```
Primero se trabaja directamente sobre la tabla de cuentas.
Luego se aplica una condición para seleccionar solo aquellas cuentas cuyo saldo es mayor a 10,000.
No es necesario usar uniones con otras tablas.

 Resultado: listado de cuentas con saldo alto.

select * from cuentas where balance > 10000;
```

# Quinta Consulta: Clientes que tienen tarjetas

```
Primero se toma la tabla de clientes.
Luego se relaciona con la tabla de tarjetas mediante el identificador del cliente.
Se utiliza una unión interna para obtener solo los clientes que tienen al menos una tarjeta.
Finalmente, se eliminan duplicados si un cliente posee más de una tarjeta.

 Resultado: clientes que cuentan con tarjetas.

 select clientes. * from clientes inner join tarjetas on clientes.id = tarjetas.id_cliente;
```

# Sexta Consulta: Numero de Cuentas por Cliente

```
Primero se relaciona la tabla de clientes con la tabla de cuentas.
Se utiliza una unión externa (LEFT JOIN) para incluir a todos los clientes, incluso los que no tienen cuentas.
Luego se cuenta cuántas cuentas tiene cada cliente.
Finalmente, se agrupan los resultados por cliente.

 Resultado: cantidad de cuentas que posee cada cliente.

 select clientes.nombres, count(cuentas.id) as total_cuentas
from clientes left join cuentas on clientes.id = cuentas.id_cliente
group by clientes.id,clientes.nombres;
```

# Septima Consulta: Préstamos Activos

```
Primero se selecciona la tabla de préstamos.
Luego se aplica un filtro para obtener únicamente los registros cuyo estado es activo.
No se requiere unión con otras tablas.

 Resultado: lista de préstamos vigentes.

 select * from prestamos where estado = 'activo';
```

# Octava Consulta: Total transferido desde cada cuenta

```
Primero se trabaja con la tabla de transferencias.
Luego se agrupan los registros según la cuenta de origen.
Después se suman los montos transferidos por cada cuenta.

 Resultado: total de dinero transferido desde cada cuenta.

 select origen, sum(monto) as total_transferido
from transferencias group by origen;
```

# Novena Consulta: Transacciones del ultimo mes

```
Primero se toma la tabla de transacciones.
Luego se obtiene la fecha actual del sistema.
Después se calcula el rango correspondiente al último mes.
Finalmente, se filtran las transacciones que se encuentran dentro de ese rango de tiempo.

 Resultado: movimientos realizados en el último mes.

 select * from transacciones where fecha_hora >= now() - interval 1 month;
```

# Decima Consulta: Clientes con inversiones mayores a 5000

```
Primero se relaciona la tabla de clientes con la tabla de inversiones.
Luego se filtran las inversiones cuyo monto es mayor a 5,000.
Se seleccionan los clientes asociados a esas inversiones.
Finalmente, se eliminan duplicados.

 Resultado: clientes con inversiones altas.

 select distinct clientes. * from clientes inner join inversiones on clientes.id
= inversiones.id_cliente where inversiones.monto > 5000;

```

# Undecima Consulta: Cliente, Cuenta y Saldo

```
Primero se relaciona la tabla de clientes con la tabla de cuentas.
Luego se seleccionan los datos relevantes: nombre del cliente, número de cuenta y saldo.
No se requiere agrupación.

 Resultado: información combinada de clientes y sus cuentas.
 select clientes.nombres, cuentas.numero, cuentas.balance from clientes inner join cuentas on clientes.id = cuentas.id_cliente;

```

# Duodecima Consulta: Total de transacciones por cuenta

```
Primero se trabaja con la tabla de transacciones.
Luego se agrupan los registros por cuenta.
Después se cuenta el número de transacciones de cada grupo.

 Resultado: número de movimientos por cuenta.

 select id_cuenta, count(*) as total_transacciones
from transacciones group by id_cuenta;
```

# Decimo Tercera Consulta: Clientes sin cuentas

```
Primero se relaciona la tabla de clientes con la tabla de cuentas utilizando LEFT JOIN.
Luego se identifican los casos donde no existe coincidencia en la tabla de cuentas.
Esto se detecta mediante valores nulos.

 Resultado: clientes que no tienen cuentas registradas.

 select clientes. * from clientes left join cuentas on clientes.id
= cuentas.id_cliente where cuentas.id is null;
```

# Decimo Cuarta Consulta: Cliente con mas cuentas

```
Primero se relacionan clientes con cuentas.
Luego se cuenta el número de cuentas por cliente.
Después se ordenan los resultados de mayor a menor.
Finalmente, se selecciona el primer registro.

 Resultado: cliente con mayor número de cuentas.

 SELECT clientes.nombres, COUNT(cuentas.id) AS total_cuentas
FROM clientes
INNER JOIN cuentas  ON clientes.id = cuentas.id_cliente
GROUP BY clientes.id, clientes.nombres
ORDER BY total_cuentas DESC
LIMIT 1;

```

# Decimo Quinta: Total de Prestamos por cliente

```
Primero se relaciona la tabla de clientes con la de préstamos.
Se utiliza LEFT JOIN para incluir clientes sin préstamos.
Luego se cuentan los préstamos por cliente.
Finalmente, se agrupan los resultados.

 Resultado: cantidad de préstamos por cliente.

 SELECT clientes.nombres, COUNT(prestamos.id) AS total_prestamos
FROM clientes
LEFT JOIN prestamos ON clientes.id = prestamos.id_cliente
GROUP BY clientes.id, clientes.nombres;
```

# Decimo Sexta Consulta: Total invertido por cliente

```
Primero se relacionan clientes con inversiones.
Luego se suman los montos invertidos.
Finalmente, se agrupan los resultados por cliente.

 Resultado: total invertido por cada cliente.

 SELECT clientes.nombres, SUM(inversiones.monto) AS total_invertido
FROM clientes
INNER JOIN inversiones ON clientes.id = inversiones.id_cliente
GROUP BY clientes.id, clientes.nombres;
```

# Decimo Septima Consulta: Cuentas sin transacciones

```
Primero se relaciona la tabla de cuentas con la de transacciones usando LEFT JOIN.
Luego se identifican las cuentas que no tienen registros en transacciones.
Esto se detecta mediante valores nulos.

 Resultado: cuentas sin actividad.

 SELECT cuentas. *
FROM cuentas
LEFT JOIN transacciones ON cuentas.id = transacciones.id_cuenta
WHERE transacciones.id IS NULL;

```

# Decimo Octava Consulta: Promedio de Transacciones

```
Primero se toma la tabla de transacciones.
Luego se calcula el promedio del monto utilizando una función de agregación.

 Resultado: valor promedio de las transacciones.

 SELECT AVG(monto) AS promedio_transacciones
FROM transacciones;
```

# Decimo Novena Consulta: Top 5 clientes con mayor saldo

```
Primero se relacionan clientes con cuentas.
Luego se suman los saldos por cliente.
Después se ordenan de mayor a menor.
Finalmente, se seleccionan los cinco primeros.

 Resultado: clientes con mayor saldo.

 SELECT clientes.nombres, SUM(cuentas.balance) AS saldo_total
FROM clientes
INNER JOIN cuentas ON clientes.id = cuentas.id_cliente
GROUP BY clientes.id, clientes.nombres
ORDER BY saldo_total DESC
LIMIT 5;
```

# Vigesima Consulta: Clientes con cuentas y préstamos

```
Primero se relaciona la tabla de clientes con cuentas.
Luego se vuelve a relacionar con préstamos.
Solo se consideran los clientes que tienen ambas relaciones.

 Resultado: clientes con cuentas y préstamos.

 SELECT DISTINCT clientes. *
FROM clientes
INNER JOIN cuentas ON clientes.id = cuentas.id_cliente
INNER JOIN prestamos ON clientes.id = prestamos.id_cliente;
```

# Vigesimo Primera Consulta: Cliente con mayor actividad

```
Primero se relacionan clientes, cuentas y transacciones.
Luego se cuentan las transacciones por cliente.
Después se ordenan de mayor a menor.
Finalmente, se selecciona el primero.

 Resultado: cliente más activo.

 SELECT clientes.nombres, COUNT(transacciones.id) AS total_transacciones
FROM clientes
INNER JOIN cuentas ON clientes.id = cuentas.id_cliente
INNER JOIN transacciones ON cuentas.id = transacciones.id_cuenta
GROUP BY clientes.id, clientes.nombres
ORDER BY total_transacciones DESC
LIMIT 1;
```

# Vigesimo Segunda Consulta: Transferencias Sospechosas

```
Primero se agrupan las transferencias por cuenta y por día.
Luego se cuenta cuántas transferencias hay en cada grupo.
Después se filtran los casos donde el número es mayor a tres.

 Resultado: posibles transferencias sospechosas.

 SELECT origen, DATE(fecha_hora) AS fecha, COUNT(*) AS total
FROM transferencias
GROUP BY origen, DATE(fecha_hora)
HAVING COUNT(*) > 3;
```

# Vigesimo Tercera Consulta : Clientes con deudas que saldos

```
Primero se relacionan clientes con cuentas y préstamos.
Luego se suman los saldos y los préstamos.
Después se comparan ambos valores.
Se seleccionan los casos donde la deuda es mayor al saldo.

 Resultado: clientes en situación financiera crítica.

 SELECT clientes.nombres,
       SUM(cuentas.balance) AS total_saldo,
       SUM(prestamos.monto) AS total_prestamos
FROM clientes
INNER JOIN cuentas ON clientes.id = cuentas.id_cliente
INNER JOIN prestamos ON clientes.id = prestamos.id_cliente
GROUP BY clientes.id, clientes.nombres
HAVING total_saldo < total_prestamos;
```

# Vigesimo Cuarta Consulta: Ranking de clientes por inversiones

```
Primero se suman las inversiones por cliente.
Luego se ordenan los resultados.
Después se asigna una posición a cada cliente utilizando una función de ranking.

 Resultado: ranking de inversionistas.

 SELECT clientes.nombres,
       SUM(inversiones.monto) AS total_inversion,
       RANK() OVER (ORDER BY SUM(inversiones.monto) DESC) AS ranking
FROM clientes
INNER JOIN inversiones ON clientes.id = inversiones.id_cliente
GROUP BY clientes.id, clientes.nombres;
```

# Vigesimo Quinta Consulta: Crecimiento de Inversiones

```
Primero se relacionan clientes con inversiones.
Luego se compara el monto inicial con el valor actual.
Finalmente, se calcula la diferencia entre ambos valores.

 Resultado: ganancia o pérdida de cada inversión.

 SELECT clientes.nombres,
       inversiones.monto,
       inversiones.valor_actual,
       (inversiones.valor_actual - inversiones.monto) AS ganancia
FROM clientes
INNER JOIN inversiones ON clientes.id = inversiones.id_cliente;
```
