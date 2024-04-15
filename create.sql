CREATE TABLE LUGAR(
    id INT  AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(20)NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    fk_tipo INT,
    CONSTRAINT lugar_pk PRIMARY KEY(id),
    CONSTRAINT lugar_fk FOREIGN KEY(fk_tipo) REFERENCES LUGAR(id)
);

CREATE TABLE CLIENTE(
    cedula_cli INT UNIQUE,
    nombre_cli VARCHAR(20) NOT NULL,
    apellido_cli VARCHAR(20) NOT NULL,
    genero char NOT NULL,
    fk_lugar INT,
    CONSTRAINT cliente_pk PRIMARY KEY(cedula_cli),
    CONSTRAINT lp_fk_cliente FOREIGN KEY(fk_lugar) REFERENCES LUGAR(id),
    CONSTRAINT check_genero_cliente CHECK (genero = 'M' or genero = 'F')
);

CREATE TABLE EMPLEADO(
    cedula_emp INT UNIQUE,
    nombre_emp VARCHAR(20) NOT NULL,
    apellido_emp VARCHAR(20) NOT NULL,
    fecha_nac DATE NOT NULL,
    genero char NOT NULL,
    correo VARCHAR(50) NOT NULL,
    telefono INT NOT NULL,
    fk_lugar INT,
    CONSTRAINT empleado_pk PRIMARY KEY(cedula_emp),
    CONSTRAINT lp_fk_empleado FOREIGN KEY(fk_lugar) REFERENCES LUGAR(id),
    CONSTRAINT ch_genero_empleado CHECK(genero IN('M','F'))
);

CREATE TABLE FACTURA(
    id_factura INT AUTO_INCREMENT,
    fecha_emision DATE NOT NULL,
    total INT NOT NULL,
    cliente_fk INT,
    fk_empleado INT,
    CONSTRAINT factura_pk PRIMARY KEY(id_factura),
    CONSTRAINT fact_cli_fk FOREIGN KEY(cliente_fk) REFERENCES CLIENTE(cedula_cli),
    CONSTRAINT fact_emp_fk FOREIGN KEY(fk_empleado) REFERENCES EMPLEADO(cedula_emp)
);

CREATE TABLE CONTRATO_EMPLEADO(
    id_contrato INT AUTO_INCREMENT,
    fecha_ingreso DATE NOT NULL,
    fecha_egreso DATE,
    CONSTRAINT id_contrato PRIMARY KEY(id_contrato)
);

CREATE TABLE HORARIO(
    id_horario INT AUTO_INCREMENT,
    hora_entrada TIME NOT NULL,
    hora_salida TIME NOT NULL,
    CONSTRAINT horario_pk PRIMARY KEY(id_horario)
);

CREATE TABLE C_H(
    id_cont_hor INT AUTO_INCREMENT,
    contrato_fk INT NOT NULL,
    fk_horario INT NOT NULL,
    CONSTRAINT c_h_pk PRIMARY KEY(id_cont_hor),
    CONSTRAINT fk_ch_hor FOREIGN KEY(fk_horario) REFERENCES HORARIO(id_horario),
    CONSTRAINT fk_ch_contrato FOREIGN KEY(contrato_fk) REFERENCES CONTRATO_EMPLEADO(id_contrato)
);

CREATE TABLE CARGO(
    id_cargo INT AUTO_INCREMENT,
    nombre_cargo VARCHAR(50) NOT NULL,
    sueldo_diario INT NOT NULL,
    CONSTRAINT cargo_pk PRIMARY KEY(id_cargo)
);

CREATE TABLE CATEGORIA(
    id_categoria INT AUTO_INCREMENT,
    nombre_categoria VARCHAR(50) NOT NULL,
    CONSTRAINT categoria_pk PRIMARY KEY(id_categoria)
);

CREATE TABLE PRODUCTO(
    id_producto INT AUTO_INCREMENT,
    nombre_p VARCHAR(50) NOT NULL,
    descripcion_p VARCHAR(50) NOT NULL,
    fk_categoria INT,
    CONSTRAINT producto_pk PRIMARY KEY(id_producto),
    CONSTRAINT cat_prod_fk FOREIGN KEY(fk_categoria) REFERENCES CATEGORIA(id_categoria)
);

CREATE TABLE C_C(
    id_cargo_cont INT AUTO_INCREMENT,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    sueldo INT NOT NULL,
    fk_cargo INT NOT NULL,
    cont_fk INT NOT NULL,
    CONSTRAINT cc_pk PRIMARY KEY(id_cargo_cont),
    CONSTRAINT cc_cargo_fk FOREIGN KEY(fk_cargo) REFERENCES CARGO(id_cargo),
    CONSTRAINT cc_cont_fk FOREIGN KEY(cont_fk) REFERENCES CONTRATO_EMPLEADO(id_contrato)
);

CREATE TABLE FARMACIA(
    id_farmacia INT AUTO_INCREMENT,
    capacidad INT NOT NULL,
    CONSTRAINT farmacia_pk PRIMARY KEY(id_farmacia)
);

CREATE TABLE ENTRADA_SALIDA(
    id_ent_sal INT AUTO_INCREMENT,
    hora_fecha_entrada DATETIME NOT NULL,
    hora_fecha_salida DATETIME,
    fk_contrato INT NOT NULL,
    CONSTRAINT ent_sal_pk PRIMARY KEY(id_ent_sal),
    CONSTRAINT esc_fk FOREIGN KEY(fk_contrato) REFERENCES CONTRATO_EMPLEADO(id_contrato)
);

CREATE TABLE INVENTARIO(
    id_inventario INT AUTO_INCREMENT,
    cantidad_disp INT NOT NULL,
    fk_farmacia INT NOT NULL,
    CONSTRAINT inventario_pk PRIMARY KEY(id_inventario),
    CONSTRAINT far_inv_fk FOREIGN KEY(fk_farmacia) REFERENCES FARMACIA(id_farmacia)
);

CREATE TABLE DETALLE_FACTURA(
    id_det_fact INT AUTO_INCREMENT,
    cantidad_prod INT NOT NULL,
    precio_unitario INT NOT NULL,
    descuento INT,
    fk_factura INT  NOT NULL,
    fk_inventario INT NOT NULL,
    CONSTRAINT det_fact_pk PRIMARY KEY(id_det_fact),
    CONSTRAINT detfact_fact_fk FOREIGN KEY(fk_factura) REFERENCES FACTURA(id_factura),
    CONSTRAINT detfact_inv_fk FOREIGN KEY(fk_inventario) REFERENCES INVENTARIO(id_inventario)
);

CREATE TABLE HIST_PRECIO_COMPRA(
    id_pc INT AUTO_INCREMENT,
    valor_pc INT NOT NULL,
    fecha_inicio_pc DATE NOT NULL,
    fecha_fin_pc DATE,
    fk_producto INT,
    CONSTRAINT pc_pk PRIMARY KEY(id_pc),
    CONSTRAINT pc_pro_fk FOREIGN KEY(fk_producto) REFERENCES PRODUCTO(id_producto)
);

CREATE TABLE HIST_TASA_DOLAR(
    id_td INT AUTO_INCREMENT,
    valor_td INT NOT NULL,
    fecha_inicio_td DATE NOT NULL,
    fecha_fin_td DATE,
    fk_hist_pc INT,
    CONSTRAINT td_pk PRIMARY KEY(id_td),
    CONSTRAINT td_pc_fk FOREIGN KEY(fk_hist_pc) REFERENCES HIST_PRECIO_COMPRA(id_pc)
);

CREATE TABLE HIST_PRECIO_VENTA(
    id_pv INT AUTO_INCREMENT,
    valor_pv INT NOT NULL,
    fecha_inicio_pv DATE NOT NULL,
    fecha_fin_pv DATE,
    fk_inv INT,
    fk_hist_td INT,
    CONSTRAINT pv_pk PRIMARY KEY(id_pv),
    CONSTRAINT pv_inv_fk FOREIGN KEY(fk_inv) REFERENCES INVENTARIO(id_inventario),
    CONSTRAINT td_pv_fk FOREIGN KEY(fk_hist_td) REFERENCES HIST_TASA_DOLAR(id_td)
);

