
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
		SELECT P.id_producto, P.nombre_p, SUM(V.cantidad) AS Cantidad_Vendida
		FROM PRODUCTO P
		JOIN VENTAS V ON P.id_producto = V.producto_fk
		GROUP BY P.id_producto
		ORDER BY Cantidad_Vendida DESC;
END //

DELIMITER ;

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
        C.sueldo_hora
    FROM 
        EMPLEADO E
    JOIN 
        C_C CC ON E.cedula_emp = CC.cont_fk
    JOIN 
        CARGO C ON CC.fk_cargo = C.id_cargo
    WHERE 
        CC.fecha_fin IS NULL
    ORDER BY 
        C.sueldo_hora DESC;
END //

DELIMITER ;

--Reporte6
DELIMITER //

CREATE PROCEDURE reporte6()
BEGIN
    SELECT 
        P.id_producto, 
        P.nombre_p, 
        SUM(I.cantidad_disp) AS Cantidad_En_Inventario
    FROM 
        PRODUCTO P
    JOIN 
        INVENTARIO I ON P.id_producto = I.producto_fk
    GROUP BY 
        P.id_producto, P.nombre_p
    ORDER BY 
        Cantidad_En_Inventario DESC;
END //

DELIMITER ;

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
