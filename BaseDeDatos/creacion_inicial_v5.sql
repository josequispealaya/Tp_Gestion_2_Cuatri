/*
-------------------------------------------------------------------------------
SECCIONES
-------------------------------------------------------------------------------
SECCION_0 : HISTORIAL DE CAMBIOS
SECCION_1 : CREACION DEL ESQUEMA
SECCION_2 : ELIMINACI�N DE TABLAS
SECCION_3 : CREACI�N DE LAS TABLAS & DEFINICI�N DE CONSTRAINTS
SECCION_4 : DEFINICION DE ROLES Y USUARIOS
SECCION_5 : MIGRACION DE DATOS DE TABLA MAESTRA
SECCION_6 : CREACI�N DE VIEWS
SECCION_7 : CREACI�N DE FUNCTIONS, PROCEDURES, TRIGGERS
SECCION_8 : ACTIVACI�N DE CONSTRAINTS POST-MIGRACI�N

-------------------------------------------------------------------------------
*/

/* ****************************************************************************
* SECCION_0 : HISTORIAL DE CAMBIOS
**************************************************************************** */

/*

FECHA			DESCRIPCI�N DEL CAMBIO
-------------------------------------------------------------------------------
09/SEP/2016		Creaci�n del archivo (v1).
09/SEP/2016		Conformaci�n de las secciones del archivo.
17/SEP/2016		Definicion nombre del esquema a usar y se comienza con la definici�n de tablas.
20/SEP/2016		Se agrega comentario sobre constraint en tabla 'SOLARIS.Paciente'.
20/SEP/2016		Cambio en orden de secciones. 'MIGRACION DE DATOS DE TABLA MAESTRA' pasa de secci�n 8 a 6.
21/SEP/2016		Se eliminan secciones de PK & FK. Estas definiciones se incorporan a la secci�n de definicion de tablas para mayor claridad.
21/SEP/2016		Se agrega la seccion de 'Eliminacion de tablas' para eliminar las tablas en correcto orden antes de la creaci�n.
21/SEP/2016		Se definen PKs.
21/SEP/2016		(v2).
21/SEP/2016		Se definen FKs.
21/SEP/2016		Correccion tipo dato 'pac_plan_medico' en tabla 'Paciente'.
24/SEP/2016		Correcciones en numeracion de secciones.
24/SEP/2016		Se agrega la carga manual de tabla 'Estado_Turno' en secci�n 4.
24/SEP/2016		Correcciones en Secci�n 1. Se agreg� el par�ntesis del IF.
24/SEP/2016		Se cambia tabla para verificar schema en seccion 1. ANTES: 'sys.schemas'. AHORA: 'INFORMATION_SCHEMA.SCHEMATA'.
24/SEP/2016		Se modific� el orden del la eliminaci�n de tablas para corregir errores al eliminar tablas.
24/SEP/2016		Se comienza con la secci�n 5 (Migraci�n). [Plan_Medico, Tipo_Especialidades, Especialidades, Medico, Medico_x_Especialidad].
xx/SEP/2016		Se corrige el nombre del schema [DE: Solaris A: SOLARIS].
xx/SEP/2016		Se corrige el campo para el password en la tabla Usuario.
xx/SEP/2016		(v3).
01/OCT/2016		Se agrega tabla 'Hist_Plan_Afiliado'.
01/OCT/2016		Se agrega campo 'esta_activo' en tablas: Paciente & Rol & Medico.
01/OCT/2016		Se cambia el nombre de tabla 'Bono' a 'Bono_Consulta'.
01/OCT/2016		Se cambia el campo bon_estado (tinyint) a bon_fue_utilizado (bit) en 'Bono_Consulta'.
01/OCT/2016		Se elimina la tabla 'Dia' y las referencias a ella en otras tablas.
01/OCT/2016		Se agregan constraints CK para verificar el dia de la semana en tablas 'Horario' & 'Agenda'.
01/OCT/2016		Se agrega la tabla 'Relaci�n' y se cargan sus datos manualmente en secci�n 4.
01/OCT/2016		Se agrega el campo 'pac_codigo' en tabla 'Paciente' y se setea como PK �nica.
01/OCT/2016		Se modifican las referencias (FK) a tabla 'Paciente' usando la nueva PK.
01/OCT/2016		Se migran los datos a la tabla 'Paciente'.
01/OCT/2016		(v4).
05/OCT/2016		Se agrega la fecha de baja en la tabla Paciente.
05/OCT/2016		Se agrega la seccion 8, para ctivar constraints post-migraci�n.
06/OCT/2016		Se modifica el cod del afiliado y el nro del afiliado, todo a un s�lo campo.
06/OCT/2016		Como resultado de la modificaci�n anterior, no es necesario la secci�n 8 y es eliminada.
06/OCT/2016		Se crea el procedimiento para la migraci�n de Pacientes, genrando un nro de afiliado titular durante la migraci�n.
07/OCT/2016		Se agrega el campo 'hpa_plan_nuevo' en tabla Hist_Plan_Afiliado.
07/OCT/2016		En 'Estado_Turno' se agraga el estado = 4 & se modifica el tama�o del campo descripcion del estado.
09/OCT/2016		Se agregan los primeros procedimientos en el apartado 7, los mismos son usados en la app.
*/


--Indico DB a utilizar
USE GD2C2016;


/* ****************************************************************************
* SECCION_1 : CREACION DEL ESQUEMA
**************************************************************************** */

--Si no existe el esquema, entonces, lo creo
IF (NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'SOLARIS'))
	BEGIN
		PRINT 'Creando schema ...';
		EXEC ('CREATE SCHEMA SOLARIS AUTHORIZATION gd');
	END;



/* ****************************************************************************
* SECCION_2 : ELIMINACI�N DE TABLAS
**************************************************************************** */

PRINT 'Eliminando tablas ...';

-- Tabla "Roles x Usuario"
IF OBJECT_ID('SOLARIS.Rol_x_Usuario') IS NOT NULL
	DROP TABLE SOLARIS.Rol_x_Usuario;

-- Tabla "Funcionalidades x Rol"
IF OBJECT_ID('SOLARIS.Funcionalidad_x_Rol') IS NOT NULL
	DROP TABLE SOLARIS.Funcionalidad_x_Rol;

-- Tabla "Rol"
IF OBJECT_ID('SOLARIS.Rol') IS NOT NULL
	DROP TABLE SOLARIS.Rol;

-- Tabla "Funcionalidades"
IF OBJECT_ID('SOLARIS.Funcionalidad') IS NOT NULL
	DROP TABLE SOLARIS.Funcionalidad;

-- Tabla "Especialidad x Medico"
-- Precede a: "Medico", "Especialidad"
IF OBJECT_ID('SOLARIS.Especialidad_x_Medico') IS NOT NULL
	DROP TABLE SOLARIS.Especialidad_x_Medico;

-- Tabla "Agenda"
-- Precede a: "Medico", "Especialidad", "Dia"
IF OBJECT_ID('SOLARIS.Agenda') IS NOT NULL
	DROP TABLE SOLARIS.Agenda;

-- Tabla "Especialidad"
-- Precede a: "Tipo_Especialidad"
IF OBJECT_ID('SOLARIS.Especialidad') IS NOT NULL
	DROP TABLE SOLARIS.Especialidad;

-- Tabla "Tipo Especialidad"
IF OBJECT_ID('SOLARIS.Tipo_Especialidad') IS NOT NULL
	DROP TABLE SOLARIS.Tipo_Especialidad;

-- Tabla "Bono_Consulta"
-- Precede a: "Paciente"
IF OBJECT_ID('SOLARIS.Bono_Consulta') IS NOT NULL
	DROP TABLE SOLARIS.Bono_Consulta;

-- Tabla "Consulta"
-- Precede a: "Bono","Turno"
IF OBJECT_ID('SOLARIS.Consulta') IS NOT NULL
	DROP TABLE SOLARIS.Consulta;

-- Tabla "Turno"
IF OBJECT_ID('SOLARIS.Turno') IS NOT NULL
	DROP TABLE SOLARIS.Turno;

-- Tabla "Estado Turno"
IF OBJECT_ID('SOLARIS.Estado_Turno') IS NOT NULL
	DROP TABLE SOLARIS.Estado_Turno;

-- Tabla "Medico"
-- Precede a: "Usuario", "Tipo de Documento"
IF OBJECT_ID('SOLARIS.Medico') IS NOT NULL
	DROP TABLE SOLARIS.Medico;

-- Tabla "Horario" (Para los horarios de la cl�nica)
-- Precede a: "Dia"
IF OBJECT_ID('SOLARIS.Horario') IS NOT NULL
	DROP TABLE SOLARIS.Horario;
	
-- Tabla "Dia"
/*
IF OBJECT_ID('SOLARIS.Dia') IS NOT NULL
	DROP TABLE SOLARIS.Dia;
*/

-- Tabla "Bono_Bono_Farmacia"
IF OBJECT_ID('SOLARIS.Bono_Farmacia') IS NOT NULL
	DROP TABLE SOLARIS.Bono_Farmacia;

-- Tabla "Hist_Plan_Afiliado"
IF OBJECT_ID('SOLARIS.Hist_Plan_Afiliado') IS NOT NULL
	DROP TABLE SOLARIS.Hist_Plan_Afiliado;

-- Tabla "Paciente"
-- Precede a: "Usuario", "Plan_Medico", "Tipo de Documento", "Estado Civil".
IF OBJECT_ID('SOLARIS.Paciente') IS NOT NULL
	DROP TABLE SOLARIS.Paciente;

-- Tabla "Relacion"
IF OBJECT_ID('SOLARIS.Relacion') IS NOT NULL
	DROP TABLE SOLARIS.Relacion;

-- Tabla "Estado Civil"
IF OBJECT_ID('SOLARIS.Estado_Civil') IS NOT NULL
	DROP TABLE SOLARIS.Estado_Civil;

-- Tabla "Tipo de Documento"
IF OBJECT_ID('SOLARIS.Tipo_Documento') IS NOT NULL
	DROP TABLE SOLARIS.Tipo_Documento;

-- Tabla "Plan_Medico"
IF OBJECT_ID('SOLARIS.Plan_Medico') IS NOT NULL
	DROP TABLE SOLARIS.Plan_Medico;


-- Tabla "Usuario"
IF OBJECT_ID('SOLARIS.Usuario') IS NOT NULL
	DROP TABLE SOLARIS.Usuario;

-- Tabla "Estado Usuario"
IF OBJECT_ID('SOLARIS.Usuario_Estado') IS NOT NULL
	DROP TABLE SOLARIS.Usuario_Estado;


PRINT 'Tablas eliminadas ...';


/* ****************************************************************************
* SECCION_3 : CREACI�N DE LAS TABLAS & DEFINICI�N DE CONSTRAINTS
**************************************************************************** */

PRINT 'Creando tablas ...';


-- Tabla "Estado Usuario"
CREATE TABLE SOLARIS.Usuario_Estado (
	ues_codigo		TINYINT	NOT NULL,
	ues_descipcion	VARCHAR(11)
);

ALTER TABLE SOLARIS.Usuario_Estado ADD CONSTRAINT PK_Estado_Usuario PRIMARY KEY(ues_codigo);


-- Tabla "Usuario"
CREATE TABLE SOLARIS.Usuario (
	usu_codigo			INT IDENTITY(1,1),
	usu_usuario			VARCHAR(8)	NOT NULL,
	usu_passwd			VARBINARY(255)  	NOT NULL,
	usu_fecha_creacion	DATETIME,
	usu_estado			TINYINT,		-- [FK] Ref 'Estado Usuarios'
	usu_login_fallidos	TINYINT	
);

ALTER TABLE SOLARIS.Usuario ADD CONSTRAINT PK_Usuario PRIMARY KEY(usu_codigo);
ALTER TABLE SOLARIS.Usuario ADD CONSTRAINT FK_Usuario_01 FOREIGN KEY (usu_estado) REFERENCES SOLARIS.Usuario_Estado(ues_codigo);

ALTER TABLE SOLARIS.Usuario ADD CONSTRAINT UQ_Nombre_Usuario UNIQUE (usu_usuario);
ALTER TABLE SOLARIS.Usuario ADD CONSTRAINT DF_Login_Fallido_En_Cero DEFAULT 0 FOR usu_login_fallidos;


-- Tabla "Rol"
CREATE TABLE SOLARIS.Rol (
	rol_codigo		TINYINT	IDENTITY(1,1) NOT NULL,
	rol_nombre		VARCHAR(25) NOT NULL,
	rol_esta_activo	BIT
);

ALTER TABLE SOLARIS.Rol ADD CONSTRAINT PK_Rol PRIMARY KEY(rol_codigo);
ALTER TABLE SOLARIS.Rol ADD CONSTRAINT DF_Activo_Al_Crearse DEFAULT 1 FOR rol_esta_activo;
ALTER TABLE SOLARIS.Rol ADD CONSTRAINT CK_EstaActivo CHECK (rol_esta_activo = 0 OR rol_esta_activo = 1);


-- Tabla "Roles x Usuario"
CREATE TABLE SOLARIS.Rol_x_Usuario (
	rxu_usuario		INT	NOT NULL,
	rxu_rol			TINYINT NOT NULL
);

ALTER TABLE SOLARIS.Rol_x_Usuario ADD CONSTRAINT PK_Rol_x_Usuario PRIMARY KEY(rxu_usuario, rxu_rol);
ALTER TABLE SOLARIS.Rol_x_Usuario ADD CONSTRAINT FK_Rol_x_Usuario_01 FOREIGN KEY (rxu_usuario) REFERENCES SOLARIS.Usuario(usu_codigo);
ALTER TABLE SOLARIS.Rol_x_Usuario ADD CONSTRAINT FK_Rol_x_Usuario_02 FOREIGN KEY (rxu_rol) REFERENCES SOLARIS.Rol(rol_codigo);


-- Tabla "Funcionalidades"
CREATE TABLE SOLARIS.Funcionalidad (
	fun_codigo	TINYINT NOT NULL,
	fun_nombre	VARCHAR(22)
);

ALTER TABLE SOLARIS.Funcionalidad ADD CONSTRAINT PK_Funcionalidad PRIMARY KEY(fun_codigo);
ALTER TABLE SOLARIS.Funcionalidad ADD CONSTRAINT UQ_Nombre_Funcionalidad UNIQUE (fun_nombre);


-- Tabla "Funcionalidades x Rol"
CREATE TABLE SOLARIS.Funcionalidad_x_Rol (
	fxr_rol				TINYINT NOT NULL,
	fxr_funcionalidad	TINYINT NOT NULL
);

ALTER TABLE SOLARIS.Funcionalidad_x_Rol ADD CONSTRAINT PK_Funcionalidad_x_Rol PRIMARY KEY(fxr_rol, fxr_funcionalidad);

ALTER TABLE SOLARIS.Funcionalidad_x_Rol 
	ADD CONSTRAINT FK_Funcionalidad_x_Rol_01 FOREIGN KEY (fxr_rol) REFERENCES SOLARIS.Rol(rol_codigo);
ALTER TABLE SOLARIS.Funcionalidad_x_Rol 
	ADD CONSTRAINT FK_Funcionalidad_x_Rol_02 FOREIGN KEY (fxr_funcionalidad) REFERENCES SOLARIS.Funcionalidad(fun_codigo);


-- Tabla "Tipo de Documento"
CREATE TABLE SOLARIS.Tipo_Documento (
	tdc_codigo		TINYINT IDENTITY(1,1),
	tdc_sigla		CHAR(3),
	tdc_descripcion	VARCHAR(34)
);

ALTER TABLE SOLARIS.Tipo_Documento ADD CONSTRAINT PK_Tipo_Documento PRIMARY KEY(tdc_codigo);
ALTER TABLE SOLARIS.Tipo_Documento ADD CONSTRAINT UQ_Sigla_Documento UNIQUE (tdc_sigla);


-- Tabla "Estado Civil"
CREATE TABLE SOLARIS.Estado_Civil (
	ecv_codigo		TINYINT IDENTITY(1,1),
	ecv_descripcion	VARCHAR(13)
);

ALTER TABLE SOLARIS.Estado_Civil ADD CONSTRAINT PK_Estado_Civil PRIMARY KEY(ecv_codigo);
ALTER TABLE SOLARIS.Estado_Civil ADD CONSTRAINT UQ_Estado_Civil UNIQUE (ecv_descripcion);


-- Tabla "Plan_Medico"
CREATE TABLE SOLARIS.Plan_Medico (
	plm_codigo					NUMERIC(18,0) NOT NULL,
	plm_descripcion				VARCHAR(255),
	plm_precio_bono_consulta	NUMERIC(18,0),
	plm_precio_bono_farmacia	NUMERIC(18,0),
	plm_esta_activo				BIT
);

ALTER TABLE SOLARIS.Plan_Medico ADD CONSTRAINT PK_Plan_Medico PRIMARY KEY(plm_codigo);
ALTER TABLE SOLARIS.Plan_Medico ADD CONSTRAINT CK_Precio_Consulta_Positivo CHECK (plm_precio_bono_consulta >= 0);
ALTER TABLE SOLARIS.Plan_Medico ADD CONSTRAINT CK_Precio_Farmacia_Positivo CHECK (plm_precio_bono_farmacia >= 0);
ALTER TABLE SOLARIS.Plan_Medico ADD CONSTRAINT CK_Plan_EstaActivo CHECK (plm_esta_activo = 0 OR plm_esta_activo = 1);


-- Tabla "Relacion"
CREATE TABLE SOLARIS.Relacion (
	rel_codigo		TINYINT IDENTITY NOT NULL,
	rel_descripcion	VARCHAR(20)
);

ALTER TABLE SOLARIS.Relacion ADD CONSTRAINT PK_Relacion PRIMARY KEY(rel_codigo);


-- Tabla "Paciente"
CREATE TABLE SOLARIS.Paciente (
	pac_nro_afiliado	INT NOT NULL,
	pac_usuario			INT,		-- [FK]
	pac_apellido		VARCHAR(255),
	pac_nombre			VARCHAR(255),
	pac_tipo_doc		TINYINT,	-- [FK]
	pac_nro_doc			NUMERIC(18,0),
	pac_direccion		VARCHAR(255),
	pac_telefono		NUMERIC(18,0),
	pac_mail			VARCHAR(255),
	pac_fecha_nac		DATETIME,
	pac_sexo			CHAR(1),
	pac_estado_civil	TINYINT,	-- [FK]
	pac_cant_familiares	TINYINT,
	pac_plan_medico		NUMERIC(18,0),	-- [FK]
	--pac_titular			INT,			-- [FK]
	pac_tit_relacion	TINYINT,		-- [FK]
	pac_esta_activo		BIT,
	pac_fecha_baja		DATETIME
);


ALTER TABLE SOLARIS.Paciente ADD CONSTRAINT PK_Paciente PRIMARY KEY(pac_nro_afiliado);

ALTER TABLE SOLARIS.Paciente ADD CONSTRAINT FK_Paciente_01 FOREIGN KEY (pac_usuario) REFERENCES SOLARIS.Usuario(usu_codigo);
ALTER TABLE SOLARIS.Paciente ADD CONSTRAINT FK_Paciente_02 FOREIGN KEY (pac_tipo_doc) REFERENCES SOLARIS.Tipo_Documento(tdc_codigo);
ALTER TABLE SOLARIS.Paciente ADD CONSTRAINT FK_Paciente_03 FOREIGN KEY (pac_estado_civil) REFERENCES SOLARIS.Estado_Civil(ecv_codigo);
ALTER TABLE SOLARIS.Paciente ADD CONSTRAINT FK_Paciente_04 FOREIGN KEY (pac_plan_medico) REFERENCES SOLARIS.Plan_Medico(plm_codigo);
ALTER TABLE SOLARIS.Paciente ADD CONSTRAINT FK_Paciente_06 FOREIGN KEY (pac_tit_relacion) REFERENCES SOLARIS.Relacion(rel_codigo);

ALTER TABLE SOLARIS.Paciente ADD CONSTRAINT CK_Afiliado_EstaActivo CHECK (pac_esta_activo = 0 OR pac_esta_activo = 1);


-- Tabla "Hist_Plan_Afiliado"

CREATE TABLE SOLARIS.Hist_Plan_Afiliado (
	hpa_cod_afiliado	INT NOT NULL,				-- [FK]
	hpa_plan_anterior	NUMERIC(18,0)	NOT NULL,	-- [FK]
	hpa_plan_nuevo		NUMERIC(18,0)	NOT NULL,	-- [FK]
	hpa_fecha_cambio	DATETIME		NOT NULL,
	hpa_comentarios		VARCHAR(1022)
);

ALTER TABLE SOLARIS.Hist_Plan_Afiliado 
	ADD CONSTRAINT PK_Hist_Plan_Afiliado PRIMARY KEY(hpa_cod_afiliado, hpa_plan_anterior, hpa_plan_nuevo, hpa_fecha_cambio);

ALTER TABLE SOLARIS.Hist_Plan_Afiliado 
	ADD CONSTRAINT FK_Hist_Plan_Afiliado_01 FOREIGN KEY (hpa_cod_afiliado) REFERENCES SOLARIS.Paciente(pac_nro_afiliado);
ALTER TABLE SOLARIS.Hist_Plan_Afiliado 
	ADD CONSTRAINT FK_Hist_Plan_Afiliado_02 FOREIGN KEY (hpa_plan_anterior) REFERENCES SOLARIS.Plan_Medico(plm_codigo);
ALTER TABLE SOLARIS.Hist_Plan_Afiliado 
	ADD CONSTRAINT FK_Hist_Plan_Afiliado_03 FOREIGN KEY (hpa_plan_nuevo) REFERENCES SOLARIS.Plan_Medico(plm_codigo);



-- Tabla "Tipo Especialidad"
CREATE TABLE SOLARIS.Tipo_Especialidad (
	tes_codigo		NUMERIC(18,0)	NOT NULL,
	tes_descripcion	VARCHAR(255)
);

ALTER TABLE SOLARIS.Tipo_Especialidad ADD CONSTRAINT PK_Tipo_Especialidad PRIMARY KEY(tes_codigo);


-- Tabla "Especialidad"
CREATE TABLE SOLARIS.Especialidad (
	esp_codigo				NUMERIC(18,0)	NOT NULL,
	esp_descripcion			VARCHAR(255),
	esp_tipo_especialidad	NUMERIC(18,0)	-- [FK]
);

ALTER TABLE SOLARIS.Especialidad ADD CONSTRAINT PK_Especialidad PRIMARY KEY(esp_codigo);

ALTER TABLE SOLARIS.Especialidad 
	ADD CONSTRAINT FK_Especialidad_01 FOREIGN KEY (esp_tipo_especialidad) REFERENCES SOLARIS.Tipo_Especialidad(tes_codigo);


-- Tabla "Medico"
CREATE TABLE SOLARIS.Medico (
	med_cod_medico			INT IDENTITY(1,1),
	med_cod_usuario			INT,		-- [FK]
	med_apellido			VARCHAR(255),
	med_nombre				VARCHAR(255),
	med_tipo_doc			TINYINT,		-- [FK]
	med_nro_doc				NUMERIC(18,0),
	med_direccion			VARCHAR(255),
	med_telefono			NUMERIC(18,0),
	med_mail				VARCHAR(255),
	med_fecha_nac			DATETIME,
	med_sexo				CHAR(1),
	med_matricula			VARCHAR(22),
	med_esta_activo			BIT
);

ALTER TABLE SOLARIS.Medico ADD CONSTRAINT PK_Medico PRIMARY KEY(med_cod_medico);

ALTER TABLE SOLARIS.Medico ADD CONSTRAINT FK_Medico_01 FOREIGN KEY (med_cod_usuario) REFERENCES SOLARIS.Usuario(usu_codigo);
ALTER TABLE SOLARIS.Medico ADD CONSTRAINT FK_Medico_02 FOREIGN KEY (med_tipo_doc) REFERENCES SOLARIS.Tipo_Documento(tdc_codigo);

ALTER TABLE SOLARIS.Medico ADD CONSTRAINT CK_Medico_EstaActivo CHECK (med_esta_activo = 0 OR med_esta_activo = 1);


-- Tabla "Especialidad x Medico"
CREATE TABLE SOLARIS.Especialidad_x_Medico (
	exm_cod_medico			INT				NOT NULL,
	exm_cod_especialidad	NUMERIC(18,0)	NOT NULL
);

ALTER TABLE SOLARIS.Especialidad_x_Medico ADD CONSTRAINT PK_Especialidad_x_Medico PRIMARY KEY(exm_cod_medico, exm_cod_especialidad);

ALTER TABLE SOLARIS.Especialidad_x_Medico 
	ADD CONSTRAINT FK_Especialidad_x_Medico_01 FOREIGN KEY (exm_cod_medico) REFERENCES SOLARIS.Medico(med_cod_medico);
ALTER TABLE SOLARIS.Especialidad_x_Medico 
	ADD CONSTRAINT FK_Especialidad_x_Medico_02 FOREIGN KEY (exm_cod_especialidad) REFERENCES SOLARIS.Especialidad(esp_codigo);
	

-- Tabla "Dia"
/*CREATE TABLE SOLARIS.Dia (
	dia_numero		INT		NOT NULL,	
	dia_nombre		CHAR(9)
);

ALTER TABLE SOLARIS.Dia ADD CONSTRAINT PK_Dia PRIMARY KEY(dia_numero);
*/

-- Tabla "Agenda"
CREATE TABLE SOLARIS.Agenda (
	age_cod_entrada			INT IDENTITY(1,1),
	age_cod_medico			INT,			-- [FK]
	age_med_especialidad	NUMERIC(18,0),	-- [FK]
	age_dia					INT NOT NULL,
	age_hora_desde			TIME NOT NULL,
	age_hora_hasta			TIME NOT NULL,
	age_fecha_desde			DATE,
	age_fecha_hasta			DATE
);

ALTER TABLE SOLARIS.Agenda ADD CONSTRAINT PK_Agenda PRIMARY KEY(age_cod_entrada);

ALTER TABLE SOLARIS.Agenda ADD CONSTRAINT FK_Agenda_01 FOREIGN KEY (age_cod_medico) REFERENCES SOLARIS.Medico(med_cod_medico);
ALTER TABLE SOLARIS.Agenda ADD CONSTRAINT FK_Agenda_02 FOREIGN KEY (age_med_especialidad) REFERENCES SOLARIS.Especialidad(esp_codigo);
--ALTER TABLE SOLARIS.Agenda ADD CONSTRAINT FK_Agenda_03 FOREIGN KEY (age_dia) REFERENCES SOLARIS.Dia(dia_numero);

ALTER TABLE SOLARIS.Agenda ADD CONSTRAINT CK_age_dia CHECK (age_dia >= 1 AND age_dia <= 7);


-- Tabla "Horario" (Para los horarios de la cl�nica)
CREATE TABLE SOLARIS.Horario (
	hor_codigo		INT IDENTITY(1,1),
	hor_dia			INT,
	hor_hora_desde	TIME,
	hor_hora_hasta	TIME
);

ALTER TABLE SOLARIS.Horario ADD CONSTRAINT PK_Horario PRIMARY KEY(hor_codigo);

--ALTER TABLE SOLARIS.Horario ADD CONSTRAINT FK_Horario_01 FOREIGN KEY (hor_dia) REFERENCES SOLARIS.Dia(dia_numero);

ALTER TABLE SOLARIS.Horario ADD CONSTRAINT CK_hor_dia CHECK (hor_dia >= 1 AND hor_dia <= 7);


-- Tabla "Bono_Farmacia"
CREATE TABLE SOLARIS.Bono_Farmacia (
	bfm_numero				INT identity(1,1),
	bfm_precio				NUMERIC(18,0),
	bfm_fecha_compra		datetime,
	bfm_afiliado_compra		INT,				-- [FK]
	bfm_plan_afiliado		NUMERIC(18,0),		-- [FK]
);

ALTER TABLE SOLARIS.Bono_Farmacia ADD CONSTRAINT PK_Bono_Farmacia PRIMARY KEY(bfm_numero);

ALTER TABLE SOLARIS.Bono_Farmacia
	ADD CONSTRAINT FK_Bono_Farmacia_01 FOREIGN KEY (bfm_plan_afiliado) REFERENCES SOLARIS.Plan_Medico(plm_codigo);
ALTER TABLE SOLARIS.Bono_Farmacia
	ADD CONSTRAINT FK_Bono_Farmacia_02 FOREIGN KEY (bfm_afiliado_compra) REFERENCES SOLARIS.Paciente(pac_nro_afiliado);


-- Tabla "Estado Turno"
CREATE TABLE SOLARIS.Estado_Turno (
	etu_codigo	TINYINT NOT NULL,
	etu_nombre	VARCHAR(37)
);

ALTER TABLE SOLARIS.Estado_Turno ADD CONSTRAINT PK_Estado_Turno PRIMARY KEY(etu_codigo);

/*
	0 = RESERVADO
	1 = FINALIZADO
	2 = CANCELADO POR PACIENTE
	3 = CANCELADO POR MEDICO
	4 = CANCELADO POR BAJA DEL AFILIADO
*/

-- Tabla "Turno"
CREATE TABLE SOLARIS.Turno (
	tur_numero			INT NOT NULL,
	tur_afiliado		INT,		-- [FK]
	tur_medico			INT,		-- [FK]
	tur_fecha_solicitud	datetime,
	tur_fecha_turno		datetime,
	tur_estado			TINYINT,	-- [FK]
	tur_motivo_cancel	VARCHAR(255)	-- Si se cancela, se carga el motivo en este campo.
);

ALTER TABLE SOLARIS.Turno ADD CONSTRAINT PK_Turno PRIMARY KEY(tur_numero);

ALTER TABLE SOLARIS.Turno 
	ADD CONSTRAINT FK_Turno_01 FOREIGN KEY (tur_afiliado) REFERENCES SOLARIS.Paciente(pac_nro_afiliado);

ALTER TABLE SOLARIS.Turno ADD CONSTRAINT FK_Turno_02 FOREIGN KEY (tur_medico) REFERENCES SOLARIS.Medico(med_cod_medico);
ALTER TABLE SOLARIS.Turno ADD CONSTRAINT FK_Turno_03 FOREIGN KEY (tur_estado) REFERENCES SOLARIS.Estado_Turno(etu_codigo);

ALTER TABLE SOLARIS.Turno ADD CONSTRAINT DF_Cancelacion_en_null DEFAULT NULL FOR tur_motivo_cancel;
ALTER TABLE SOLARIS.Turno ADD CONSTRAINT CK_Nro_Turno CHECK (tur_numero > 0);


-- Tabla "Consulta"
CREATE TABLE SOLARIS.Consulta (
	con_numero				INT IDENTITY(1,1),
	con_fecha				datetime,
	con_turno				INT,			-- [FK]
	con_afiliado			INT,			-- [FK]
	--con_bono_relacionado	INT,			-- [FK]
	con_cod_medico			INT,			-- [FK]
	con_hora_llegada		datetime,
	con_hora_medico			datetime,
	con_diagnostico			VARCHAR(1022)
);

ALTER TABLE SOLARIS.Consulta ADD CONSTRAINT PK_Consulta PRIMARY KEY(con_numero);

ALTER TABLE SOLARIS.Consulta 
	ADD CONSTRAINT FK_Consulta_01 FOREIGN KEY (con_turno) REFERENCES SOLARIS.Turno(tur_numero);
ALTER TABLE SOLARIS.Consulta 
	ADD CONSTRAINT FK_Consulta_02 FOREIGN KEY (con_afiliado) REFERENCES SOLARIS.Paciente(pac_nro_afiliado);

/*ALTER TABLE SOLARIS.Consulta 
	ADD CONSTRAINT FK_Consulta_03 FOREIGN KEY (con_bono_relacionado) REFERENCES SOLARIS.Bono_Consulta(bon_numero);*/
ALTER TABLE SOLARIS.Consulta 
	ADD CONSTRAINT FK_Consulta_04 FOREIGN KEY (con_cod_medico) REFERENCES SOLARIS.Medico(med_cod_medico);



-- Tabla "Bono_Consulta"
CREATE TABLE SOLARIS.Bono_Consulta (
	bon_numero				INT NOT NULL,
	bon_precio				NUMERIC(18,0),
	bon_fecha_compra		datetime,
	bon_fecha_impresion		datetime,
	bon_afiliado_compra		INT,				-- [FK]
	bon_plan_afiliado		NUMERIC(18,0),		-- [FK]
	bon_nro_consulta_med	INT,				-- [FK]
	bon_fue_utilizado		BIT,
	bon_afiliado_uso		INT					-- [FK]
);


ALTER TABLE SOLARIS.Bono_Consulta ADD CONSTRAINT PK_Bono_Consulta PRIMARY KEY(bon_numero);

ALTER TABLE SOLARIS.Bono_Consulta 
	ADD CONSTRAINT FK_Bono_Consulta_01 FOREIGN KEY (bon_plan_afiliado) REFERENCES SOLARIS.Plan_Medico(plm_codigo);
ALTER TABLE SOLARIS.Bono_Consulta 
	ADD CONSTRAINT FK_Bono_Consulta_02 FOREIGN KEY (bon_afiliado_compra) REFERENCES SOLARIS.Paciente(pac_nro_afiliado);
ALTER TABLE SOLARIS.Bono_Consulta 
	ADD CONSTRAINT FK_Bono_Consulta_03 FOREIGN KEY (bon_nro_consulta_med) REFERENCES SOLARIS.Consulta(con_numero);
ALTER TABLE SOLARIS.Bono_Consulta 
	ADD CONSTRAINT FK_Bono_Consulta_04 FOREIGN KEY (bon_afiliado_uso) REFERENCES SOLARIS.Paciente(pac_nro_afiliado);

ALTER TABLE SOLARIS.Bono_Consulta ADD CONSTRAINT DF_Bono_Nuevo_Sin_Usar DEFAULT 0 FOR bon_fue_utilizado;
ALTER TABLE SOLARIS.Bono_Consulta ADD CONSTRAINT CK_bon_fue_utilizado CHECK (bon_fue_utilizado = 0 OR bon_fue_utilizado = 1);




PRINT 'Tablas creadas ...';


/* ****************************************************************************
* SECCION_4 : DEFINICION DE ROLES Y USUARIOS
**************************************************************************** */

-- Tabla "Usuario_Estado"

INSERT INTO SOLARIS.Usuario_Estado 
		(ues_codigo, ues_descipcion)
	VALUES 
		(0,'HABILITADO'),
		(1,'BLOQUEADO'),
		(2,'ELIMINADO');


-- Tabla "Rol"

INSERT INTO SOLARIS.Rol
		(rol_nombre)
	VALUES 
		('ADMIN'),
		('PACIENTE'),
		('MEDICO');
-- Tabla "Funcionalidades"
INSERT INTO SOLARIS.Funcionalidad
		(fun_codigo,fun_nombre)
	VALUES 
		(1,'Administrar Roles'),
		(2,'Administrar Afiliados'),
		(3,'Consultar Estadisticas'),
		(4,'Registrar Llegada'),
		(5,'Comprar Bonos'),
		(6,'Pedir Turno'),
		(7,'Registrar Resultados'),
		(8,'Cancelar Atencion');

-- Tabla "Roles x Funcionalidades"
INSERT INTO SOLARIS.Funcionalidad_x_Rol
		(fxr_rol, fxr_funcionalidad)
	VALUES
		((SELECT rol_codigo FROM  SOLARIS.Rol  WHERE rol_nombre = 'ADMIN'), (SELECT fun_codigo FROM SOLARIS.Funcionalidad WHERE fun_nombre = 'Administrar Roles')),
		((SELECT rol_codigo FROM  SOLARIS.Rol  WHERE rol_nombre = 'ADMIN'), (SELECT fun_codigo FROM SOLARIS.Funcionalidad WHERE fun_nombre = 'Administrar Afiliados')),
		((SELECT rol_codigo FROM  SOLARIS.Rol  WHERE rol_nombre = 'ADMIN'), (SELECT fun_codigo FROM SOLARIS.Funcionalidad WHERE fun_nombre = 'Consultar Estadisticas')),
		((SELECT rol_codigo FROM  SOLARIS.Rol  WHERE rol_nombre = 'ADMIN'), (SELECT fun_codigo FROM SOLARIS.Funcionalidad WHERE fun_nombre = 'Registrar Llegada')),
		((SELECT rol_codigo FROM  SOLARIS.Rol  WHERE rol_nombre = 'ADMIN'), (SELECT fun_codigo FROM SOLARIS.Funcionalidad WHERE fun_nombre = 'Comprar Bonos')),
		((SELECT rol_codigo FROM  SOLARIS.Rol  WHERE rol_nombre = 'ADMIN'), (SELECT fun_codigo FROM SOLARIS.Funcionalidad WHERE fun_nombre = 'Pedir Turno')),
		((SELECT rol_codigo FROM  SOLARIS.Rol  WHERE rol_nombre = 'PACIENTE'), (SELECT fun_codigo FROM SOLARIS.Funcionalidad WHERE fun_nombre = 'Comprar Bonos')),
		((SELECT rol_codigo FROM  SOLARIS.Rol  WHERE rol_nombre = 'PACIENTE'), (SELECT fun_codigo FROM SOLARIS.Funcionalidad WHERE fun_nombre = 'Pedir Turno')),
		((SELECT rol_codigo FROM  SOLARIS.Rol  WHERE rol_nombre = 'PACIENTE'), (SELECT fun_codigo FROM SOLARIS.Funcionalidad WHERE fun_nombre = 'Cancelar Atencion')),
		((SELECT rol_codigo FROM  SOLARIS.Rol  WHERE rol_nombre = 'MEDICO'), (SELECT fun_codigo FROM SOLARIS.Funcionalidad WHERE fun_nombre = 'Cancelar Atencion')),
		((SELECT rol_codigo FROM  SOLARIS.Rol  WHERE rol_nombre = 'MEDICO'), (SELECT fun_codigo FROM SOLARIS.Funcionalidad WHERE fun_nombre = 'Registrar Resultados'))

	;

-- Tabla "Tipo_Documento"

INSERT INTO SOLARIS.Tipo_Documento
		(tdc_sigla, tdc_descripcion)
	VALUES
		('DNI','DOCUMENTO NACIONAL DE IDENTIDAD'),
		('LE', 'LIBRETA DE ENROLAMIENTO'),
		('LC', 'LIBRETA CIVICA');

-- Tabla "Estado_Civil"

INSERT INTO SOLARIS.Estado_Civil
		(ecv_descripcion)
	VALUES
		('SOLTERO/A'),
		('CASADO/A'),
		('VIUDO/A'),
		('CONCUBINATO'),
		('DIVORCIADO/A');


-- Tabla "Relacion"

INSERT INTO SOLARIS.Relacion
		(rel_descripcion)
	VALUES
		('CONYUGE'),
		('HIJO/A'),
		('HERMANO/A'),
		('PADRE'),
		('MADRE'),
		('ABUELO/A'),
		('OTRO')
	;


-- Tabla "Dia"
-- 1 (Sunday) to 7 (Saturday).
/*
INSERT INTO SOLARIS.Dia
		(dia_numero, dia_nombre)
	VALUES
		(1,'DOMINGO'),
		(2,'LUNES'),
		(3,'MARTES'),
		(4,'MIERCOLES'),
		(5,'JUEVES'),
		(6,'VIERNES'),
		(7,'SABADO');
*/

-- Tabla "Horario" (Para los horarios de la cl�nica)
-- hh:mm:ss
INSERT INTO SOLARIS.Horario
		(hor_dia, hor_hora_desde, hor_hora_hasta)
	VALUES
		(2, '07:00:00', '20:00:00'),	-- D�a Lunes ...
		(3, '07:00:00', '20:00:00'),
		(4, '07:00:00', '20:00:00'),
		(5, '07:00:00', '20:00:00'),
		(6, '07:00:00', '20:00:00'),
		(7, '10:00:00', '15:00:00');	-- D�a S�bado.


-- Tabla "Estado_Turno"

INSERT INTO SOLARIS.Estado_Turno
		(etu_codigo, etu_nombre)
	VALUES
		(0, 'RESERVADO'),
		(1, 'FINALIZADO'),
		(2, 'CANCELADO POR PACIENTE'),
		(3, 'CANCELADO POR MEDICO'),
		(4, 'CANCELADO POR BAJA AFILIADO');
		

-- Tabla "Usuario" 

INSERT INTO SOLARIS.Usuario
		(usu_usuario, usu_passwd, usu_fecha_creacion, usu_estado)
	VALUES
		('ariel', HASHBYTES('SHA2_256','ariel'), NULL, 0),
		('jose', HASHBYTES('SHA2_256','jose'), NULL, 0),
		('matias', HASHBYTES('SHA2_256','matias'), NULL, 0),
		('ricardo',HASHBYTES('SHA2_256','ricardo'), NULL, 0);

-- Tabla "Roles x Usuario"

INSERT INTO SOLARIS.Rol_x_Usuario
		(rxu_usuario, rxu_rol)
	VALUES
		((SELECT u.usu_codigo FROM SOLARIS.Usuario u WHERE u.usu_usuario = 'ariel'), (SELECT r.rol_codigo FROM SOLARIS.Rol r WHERE r.rol_nombre = 'ADMIN')),
		((SELECT u.usu_codigo FROM SOLARIS.Usuario u WHERE u.usu_usuario = 'jose'), (SELECT r.rol_codigo FROM SOLARIS.Rol r WHERE r.rol_nombre = 'ADMIN')),
		((SELECT u.usu_codigo FROM SOLARIS.Usuario u WHERE u.usu_usuario = 'matias'), (SELECT r.rol_codigo FROM SOLARIS.Rol r WHERE r.rol_nombre = 'ADMIN')),
		((SELECT u.usu_codigo FROM SOLARIS.Usuario u WHERE u.usu_usuario = 'ricardo'), (SELECT r.rol_codigo FROM SOLARIS.Rol r WHERE r.rol_nombre = 'ADMIN'))
	;



/* ****************************************************************************
* SECCION_5 : 
**************************************************************************** */
GO

IF OBJECT_ID('SOLARIS.ufn_getNroUltimoAfiliado') IS NOT NULL
	DROP FUNCTION SOLARIS.ufn_getNroUltimoAfiliado;
GO
CREATE FUNCTION SOLARIS.ufn_getNroUltimoAfiliado()
	RETURNS INT
AS
BEGIN
	DECLARE @nro_afiliado INT;
	
	set @nro_afiliado = (SELECT TOP 1 pac_nro_afiliado
		FROM SOLARIS.Paciente 
		ORDER BY pac_nro_afiliado DESC);

	IF (@nro_afiliado IS NULL)
		set @nro_afiliado = 0; 
	
	RETURN @nro_afiliado;

END;



GO
IF OBJECT_ID('SOLARIS.usp_MigrarAfiliados') IS NOT NULL
	DROP PROCEDURE SOLARIS.usp_MigrarAfiliados;
GO
CREATE PROCEDURE SOLARIS.usp_MigrarAfiliados
AS
BEGIN
	-- Declaraci�n de variables
	declare @nro_afiliado		INT;
	declare @cur_apellido		VARCHAR(255);
	declare @cur_nombre			VARCHAR(255);
	declare @cur_dni			NUMERIC(18,0);
	declare @cur_direccion		VARCHAR(255);
	declare @cur_telefono		NUMERIC(18,0);
	declare @cur_mail			VARCHAR(255);
	declare @cur_fecha_nac		DATETIME;
	declare @cur_plan_medico	NUMERIC(18,0);
	
	DECLARE cur_Afiliados_tmp CURSOR FOR
		select distinct Paciente_Apellido, 
						Paciente_Nombre, 
						Paciente_Dni, 
						Paciente_Direccion, 
						Paciente_Telefono, 
						Paciente_Mail, 
						Paciente_Fecha_Nac, 
						Plan_Med_Codigo			
		from gd_esquema.Maestra
		where Paciente_Dni IS NOT NULL
		;

	OPEN cur_Afiliados_tmp;
	FETCH NEXT FROM cur_Afiliados_tmp INTO @cur_apellido,
							@cur_nombre,
							@cur_dni,
							@cur_direccion,
							@cur_telefono,
							@cur_mail,
							@cur_fecha_nac,
							@cur_plan_medico;
							
	WHILE (@@FETCH_STATUS = 0)
	BEGIN	
		set @nro_afiliado = ((FLOOR(SOLARIS.ufn_getNroUltimoAfiliado()/100) + 1) * 100) + 1;

		INSERT INTO SOLARIS.Paciente
			(	
				pac_nro_afiliado,
				pac_apellido, 
				pac_nombre, 
				pac_nro_doc, 
				pac_direccion, 
				pac_telefono, 
				pac_mail, 
				pac_fecha_nac, 
				pac_plan_medico, 
				pac_cant_familiares, 
				pac_estado_civil, 
				pac_usuario, 
				--pac_titular, 
				pac_tit_relacion, 
				pac_sexo, 
				pac_tipo_doc,
				pac_esta_activo,
				pac_fecha_baja
			)
			VALUES 
			(
				@nro_afiliado,
				@cur_apellido,
				@cur_nombre,
				@cur_dni,
				@cur_direccion,
				@cur_telefono,
				@cur_mail,
				@cur_fecha_nac,
				@cur_plan_medico,
				0,		-- Cant Familiares
				NULL,	-- Estado Civil
				NULL,	-- Usuario
				NULL,	-- Relacion con el titular
				NULL,	-- Sexo
				(select t.tdc_codigo from SOLARIS.Tipo_Documento t where t.tdc_sigla = 'DNI'),	-- Se elige DNI por default para aquellos que son migrados ...
				1,		-- Se setea el Afiliado como ACTIVO.
				NULL
			);

		FETCH NEXT FROM cur_Afiliados_tmp INTO @cur_apellido,
							@cur_nombre,
							@cur_dni,
							@cur_direccion,
							@cur_telefono,
							@cur_mail,
							@cur_fecha_nac,
							@cur_plan_medico;

	END;	-- End while

	CLOSE cur_Afiliados_tmp;
	DEALLOCATE cur_Afiliados_tmp;

END;

GO

/* ****************************************************************************
* SECCION_5 : MIGRACION DE DATOS DE TABLA MAESTRA
**************************************************************************** */

-- Carga de tabla: "Plan_Medico"

INSERT INTO SOLARIS.Plan_Medico 
		(plm_codigo, plm_descripcion, plm_precio_bono_consulta, plm_precio_bono_farmacia,plm_esta_activo)
	select	Plan_Med_Codigo, 
			Plan_Med_Descripcion, 
			Plan_Med_Precio_Bono_Consulta, 
			Plan_Med_Precio_Bono_Farmacia,
			1
	from gd_esquema.Maestra
	group by Plan_Med_Codigo, Plan_Med_Descripcion, Plan_Med_Precio_Bono_Consulta, Plan_Med_Precio_Bono_Farmacia
	order by 1
	;


-- Carga de tabla: "Tipo_Especialidad"

INSERT INTO SOLARIS.Tipo_Especialidad
		(tes_codigo, tes_descripcion)
	select	Tipo_Especialidad_Codigo, 
			Tipo_Especialidad_Descripcion
	from gd_esquema.Maestra
	where Tipo_Especialidad_Codigo IS NOT NULL
	group by Tipo_Especialidad_Codigo, Tipo_Especialidad_Descripcion
	order by 1,2
	;


-- Carga de tabla: "Especialidad"

INSERT INTO SOLARIS.Especialidad
		(esp_codigo, esp_descripcion, esp_tipo_especialidad)
	select distinct Especialidad_Codigo, Especialidad_Descripcion, Tipo_Especialidad_Codigo
	from gd_esquema.Maestra
	where Especialidad_Codigo IS NOT NULL
	order by 1
	;

-- Carga de tabla: "Medico" 

INSERT INTO SOLARIS.Medico
		(med_nro_doc, med_apellido, med_nombre, med_tipo_doc, med_direccion, med_telefono, med_mail, med_fecha_nac, med_sexo, med_matricula, med_cod_usuario, med_esta_activo)
	select distinct Medico_Dni, 
			Medico_Apellido, 
			Medico_Nombre, 
			(select tdc_codigo from SOLARIS.Tipo_Documento where tdc_sigla = 'DNI'), 
			Medico_Direccion,
			Medico_Telefono,
			Medico_Mail,
			Medico_Fecha_Nac,
			NULL,
			NULL,
			NULL,
			0
	from gd_esquema.Maestra
	where Medico_Dni IS NOT NULL
	;


-- Carga de tabla: "Especialidad_x_Medico" 
	
INSERT INTO SOLARIS.Especialidad_x_Medico
		(exm_cod_medico, exm_cod_especialidad)
	select distinct (select med_cod_medico from SOLARIS.Medico where med_nro_doc = Medico_Dni), 
		Especialidad_Codigo
	from gd_esquema.Maestra
	where Medico_Dni IS NOT NULL
	order by 1,2
	;


-- Carga de los Pacientes ...
EXEC SOLARIS.usp_MigrarAfiliados;


-- Carga de Turnos ...

INSERT INTO SOLARIS.Turno
		(tur_numero, tur_fecha_turno, tur_afiliado, tur_medico, tur_fecha_solicitud, tur_estado, tur_motivo_cancel)
	select distinct	Turno_Numero, 
					Turno_Fecha, 
					p.pac_nro_afiliado,
					mm.med_cod_medico,
					NULL,
					NULL,
					NULL
	from gd_esquema.Maestra m
		JOIN SOLARIS.Paciente p ON m.Paciente_Dni = p.pac_nro_doc
		JOIN SOLARIS.Medico mm ON m.Medico_Dni = mm.med_nro_doc
	where Turno_Numero IS NOT NULL
	;

-- Carga de Bonos_Consulta ...

INSERT INTO SOLARIS.Bono_Consulta
		(	bon_numero, 
			bon_fecha_compra, 
			bon_fecha_impresion, 
			bon_precio, 
			bon_afiliado_compra, 
			bon_plan_afiliado, 
			bon_nro_consulta_med, 
			bon_fue_utilizado,
			bon_afiliado_uso
		)
	select distinct Bono_Consulta_Numero, 
					Compra_Bono_Fecha, 
					Bono_Consulta_Fecha_Impresion,
					Plan_Med_Precio_Bono_Consulta,
					p.pac_nro_afiliado,
					Plan_Med_Codigo,
					NULL,
					0,
					NULL
	from gd_esquema.Maestra m
		JOIN SOLARIS.Paciente p ON m.Paciente_Dni = p.pac_nro_doc
	where Bono_Consulta_Numero IS NOT NULL
		AND Compra_Bono_Fecha IS NOT NULL
	;

/* ****************************************************************************
* SECCION_7 : CREACI�N DE FUNCTIONS, PROCEDURES, TRIGGERS
**************************************************************************** */
-- procedimiento de verificar logeo
GO

IF OBJECT_ID('SOLARIS.buscarUsuario') IS NOT NULL
	DROP PROCEDURE SOLARIS.buscarUsuario;
GO

GO
CREATE PROCEDURE SOLARIS.buscarUsuario
	@usu_passwd varchar(255)
	as
		select usu_usuario from SOLARIS.Usuario where HASHBYTES('SHA2_256',@usu_passwd) = usu_passwd
GO
-- procedimiento de buscar roles de un usuario especifico
GO

IF OBJECT_ID('SOLARIS.buscarRoles') IS NOT NULL
	DROP PROCEDURE SOLARIS.buscarRoles;
GO

GO
CREATE PROCEDURE SOLARIS.buscarRoles
	@usuario varchar(255)
	as
		select rol_nombre as Rol from SOLARIS.Rol_x_Usuario join SOLARIS.Rol on (rxu_rol = rol_codigo) join SOLARIS.Usuario on (rxu_usuario = usu_codigo) where usu_usuario = @usuario and rol_esta_activo=1

GO

-- procedimiento de buscar roles totales
GO

IF OBJECT_ID('SOLARIS.buscarRolesTotal') IS NOT NULL
	DROP PROCEDURE SOLARIS.buscarRolesTotal;
GO

GO
CREATE PROCEDURE SOLARIS.buscarRolesTotal
	
	as
		select rol_nombre as Rol from SOLARIS.Rol;

GO
-- procedimiento de buscar roles de un codigo especifico
GO

IF OBJECT_ID('SOLARIS.buscarRolesPorNombre') IS NOT NULL
	DROP PROCEDURE SOLARIS.buscarRolesPorNombre;
GO

GO
CREATE PROCEDURE SOLARIS.buscarRolesPorNombre
@codigo VARCHAR(25)
	
	as
		select rol_nombre as Rol from SOLARIS.Rol where rol_nombre = @codigo ;
GO

-- procedimiento de buscar funcionalidades totales
GO

IF OBJECT_ID('SOLARIS.funcionalidadesTotal') IS NOT NULL
	DROP PROCEDURE SOLARIS.funcionalidadesTotal;
GO

GO
CREATE PROCEDURE SOLARIS.funcionalidadesTotal

	
	as
		select fun_nombre as Funcionalidades from SOLARIS.Funcionalidad;
GO
-- procedimiento para insertar roles  
		
GO

IF OBJECT_ID('SOLARIS.insertaRol') IS NOT NULL
	DROP PROCEDURE SOLARIS.insertaRol;
GO

GO
CREATE PROCEDURE SOLARIS.insertaRol
@nomreROL VARCHAR(25)
	
	as
		INSERT INTO SOLARIS.Rol
		(rol_nombre,rol_esta_activo)
	VALUES 
		(@nomreROL,1)
GO
	
-- procedimiento para asociar funcionalidad a un rol  
		
GO

IF OBJECT_ID('SOLARIS.insertaFuncionalidadARol') IS NOT NULL
	DROP PROCEDURE SOLARIS.insertaFuncionalidadARol;
GO

GO
CREATE PROCEDURE SOLARIS.insertaFuncionalidadARol
@nomreROL VARCHAR(25),
@nomreFUNCIONALIDAD VARCHAR(22)	
	as
		INSERT INTO SOLARIS.Funcionalidad_x_Rol
		(fxr_rol, fxr_funcionalidad)
	VALUES
		((SELECT rol_codigo FROM  SOLARIS.Rol  WHERE rol_nombre = @nomreROL), (SELECT fun_codigo FROM SOLARIS.Funcionalidad WHERE fun_nombre = @nomreFUNCIONALIDAD));
GO


-- [EOF]