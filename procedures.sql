
--Reporte1
DELIMITER //

CREATE PROCEDURE reporte1()
BEGIN
    SELECT E.cedula_emp, E.nombre_emp, E.apellido_emp, SUM(TIMESTAMPDIFF(HOUR, ES.hora_fecha_entrada, ES.hora_fecha_salida)) AS Horas_Trabajadas
    FROM EMPLEADO E
    JOIN ENTRADA_SALIDA ES ON E.cedula_emp = ES.fk_contrato
    GROUP BY E.cedula_emp
    ORDER BY Horas_Trabajadas DESC;
END //

DELIMITER ;

--Reporte2
DELIMITER //

CREATE PROCEDURE reporte2()
BEGIN
    SELECT 
        P.id_producto, 
        P.imagen_p,
        P.nombre_p, 
        SUM(DF.cantidad_prod) AS Cantidad
    FROM 
        PRODUCTO P
    JOIN 
        INVENTARIO I ON P.id_producto = I.producto_fk
    JOIN 
        HIST_PRECIO_VENTA PV ON I.id_inventario = PV.fk_inv
    JOIN 
        DETALLE_FACTURA DF ON I.id_inventario = DF.fk_inventario
    GROUP BY 
        P.id_producto, P.nombre_p, P.imagen_p
    ORDER BY 
        Cantidad DESC;
END//

DELIMITER;

--Reporte3
DELIMITER //

CREATE PROCEDURE reporte3(IN mes INT, IN ano INT)
BEGIN
    SELECT 
        E.cedula_emp, 
        E.nombre_emp, 
        E.apellido_emp, 
        SUM(TIMESTAMPDIFF(HOUR, ES.hora_fecha_entrada, ES.hora_fecha_salida)) AS Horas_Trabajadas
    FROM 
        EMPLEADO E
    JOIN 
        ENTRADA_SALIDA ES ON E.cedula_emp = ES.fk_contrato
    WHERE 
        YEAR(ES.hora_fecha_entrada) = ano AND MONTH(ES.hora_fecha_entrada) = mes
    GROUP BY 
        E.cedula_emp
    ORDER BY 
        Horas_Trabajadas DESC;
END //

DELIMITER ;

--Reporte4
DELIMITER //

CREATE PROCEDURE reporte4(IN categoriaNombre VARCHAR(50))
BEGIN
    SELECT 
        P.id_producto, 
        P.imagen_p,
        P.nombre_p, 
        C.nombre_categoria, 
        I.cantidad_disp AS Cantidad_Disponible
    FROM 
        PRODUCTO P
    JOIN 
        CATEGORIA C ON P.fk_categoria = C.id_categoria
    JOIN 
        INVENTARIO I ON P.id_producto = I.producto_fk
    WHERE 
        C.nombre_categoria = categoriaNombre
    ORDER BY 
        Cantidad_Disponible DESC;
END //

DELIMITER ;

--Reporte5
DELIMITER //

CREATE PROCEDURE reporte5()
BEGIN
    SELECT 
        E.cedula_emp, 
        E.nombre_emp, 
        E.apellido_emp, 
        COUNT(DF.cantidad_prod) AS cantidad_vendida
    FROM 
        EMPLEADO E
    JOIN 
        C_C CC ON E.cedula_emp = CC.cont_fk
    JOIN 
        CARGO C ON CC.fk_cargo = C.id_cargo
    JOIN  
        FACTURA F ON E.cedula_emp = F.fk_empleado
    JOIN
        DETALLE_FACTURA DF ON F.id_factura = DF.fk_factura
    WHERE 
        CC.fecha_fin IS NULL
    ORDER BY 
        cantidad_vendida DESC;
END//

DELIMITER;

--Reporte6
DELIMITER //

CREATE PROCEDURE reporte6()
BEGIN
    SELECT 
        P.id_producto, 
        P.imagen_p,
        P.nombre_p, 
        C.nombre_categoria,
        SUM(DF.cantidad_prod) AS Cantidad
    FROM 
        PRODUCTO P
    JOIN 
        CATEGORIA C ON P.fk_categoria = C.id_categoria
    JOIN 
        INVENTARIO I ON P.id_producto = I.producto_fk
    JOIN 
        HIST_PRECIO_VENTA PV ON I.id_inventario = PV.fk_inv
    JOIN 
        DETALLE_FACTURA DF ON I.id_inventario = DF.fk_inventario
    GROUP BY 
        P.id_producto, P.nombre_p, P.imagen_p,C.nombre_categoria
    ORDER BY 
        Cantidad ASC;
END//

DELIMITER;

--Reporte7
DELIMITER //

CREATE PROCEDURE reporte7(IN ano INT)
BEGIN
    SELECT 
        YEAR(V.fecha_emision) AS Año_Venta, 
        MONTH(V.fecha_emision) AS Mes_Venta, 
        C.nombre_categoria, 
        SUM(F.total) AS Total_Ventas
    FROM 
        FACTURA V
    JOIN 
        CLIENTE CL ON V.cliente_fk = CL.cedula_cli
    JOIN 
        PRODUCTO P ON CL.fk_lugar = P.fk_categoria
    JOIN 
        CATEGORIA C ON P.fk_categoria = C.id_categoria
    JOIN 
        (SELECT 
            id_factura, 
            MAX(total) AS MaxTotal
         FROM 
            FACTURA
         GROUP BY 
            YEAR(fecha_emision), MONTH(fecha_emision)
        ) AS MV ON V.id_factura = MV.id_factura AND V.total = MV.MaxTotal
    WHERE 
        YEAR(V.fecha_emision) = ano
    GROUP BY 
        Año_Venta, Mes_Venta, C.nombre_categoria
    ORDER BY 
        Año_Venta, Mes_Venta, Total_Ventas DESC;
END //

DELIMITER ;

--Reporte8

DELIMITER //

CREATE PROCEDURE reporte8(
    IN anio INT,
    IN taza_impuestos DECIMAL(10,2) 
)
BEGIN
    DECLARE contador_mes INT;
    DECLARE Ventas_totales DECIMAL(10,2);
    DECLARE Gastos_Totales DECIMAL(10,2);
    DECLARE Ganancia_neta DECIMAL(10,2);
    DECLARE impuestos DECIMAL(10,2);

    
    CREATE TEMPORARY TABLE IF NOT EXISTS DataMes (
        Mes VARCHAR(20),
        Ventas_Totales DECIMAL(10,2),
        Gastos_Totales DECIMAL(10,2),
        Ganancia_neta DECIMAL(10,2),
        impuestos DECIMAL(10,2)
    );

    
    SET contador_mes = 1;
    WHILE contador_mes <= 12 DO
        
        SELECT IFNULL(SUM(total), 0) INTO Ventas_Totales
        FROM FACTURA
        WHERE fecha_emision BETWEEN @start_date AND @end_date;

        
        SELECT IFNULL(SUM(sueldo), 0) INTO Gastos_Totales
        FROM C_C
        WHERE fecha_inicio BETWEEN @start_date AND @end_date;

        
        SET Ganancia_neta = Ventas_Totales - Gastos_Totales;

        
        SET impuestos = ROUND(Ganancia_neta * (taza_impuestos / 100));

        
        INSERT INTO DataMes ( Ventas_Totales, Gastos_Totales, Ganancia_neta, impuestos)
        VALUES ( Ventas_Totales, Gastos_Totales, Ganancia_neta, impuestos);

        SET contador_mes = contador_mes + 1;
    END WHILE;

    
    SELECT * FROM DataMes;

    
    DROP TEMPORARY TABLE IF EXISTS DataMes;
END //

DELIMITER ;
