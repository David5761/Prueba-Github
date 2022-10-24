CREATE TABLE Grupo_Revisores(
	Cod_grupo int PRIMARY KEY
);

CREATE TABLE Ciudad (
	Cod_ciudad int PRIMARY KEY,
	Nombre_ciudad nvarchar

);
CREATE TABLE Universidad(
	Cod_universidad int PRIMARY KEY,
	Nombre_Universidad nvarchar,
	Cod_ciudad int 
	CONSTRAINT Ciudad_universidad FOREIGN KEY (Cod_ciudad) REFERENCES Ciudad(Cod_ciudad)

);

CREATE TABLE Grado_Academico(
	Cod_grado int PRIMARY KEY,
	Nombre_grado nvarchar

);
CREATE TABLE Docente(
	
	Cod_docente int PRIMARY KEY,
	Nombre_Docente nvarchar,
	Apellido_Docente nvarchar,
	Edad_docente int,
	Cod_grado int,
	Cod_universidad int
	CONSTRAINT docente_grado FOREIGN KEY (Cod_grado) REFERENCES Grado_Academico(Cod_grado),
	CONSTRAINT Docente_Universidad FOREIGN KEY (Cod_universidad) REFERENCES Universidad (Cod_universidad)
);

CREATE TABLE Detalle_revisores (
	Cod_grupo INT, 
	Cod_docente INT
	CONSTRAINT PK_DETALLE PRIMARY KEY (Cod_grupo,Cod_docente )
	CONSTRAINT FK_DETALLE_GRUPO FOREIGN KEY (Cod_grupo) REFERENCES Grupo_Revisores (Cod_grupo),
	CONSTRAINT FK_DETALLE_DOCENTE FOREIGN KEY (Cod_docente) REFERENCES Docente (Cod_docente)
);


CREATE TABLE Estado(
	cod_estado int PRIMARY KEY,
	Nombre_estado nvarchar
);
CREATE TABLE Propuesta_Charla(
	Cod_propuesta int PRIMARY KEY,
	Nombre_propuesta nvarchar,
	Descripcion text,
	Cod_docente int,
	Revisores_cod_grupo int,
	cod_Estado int

	CONSTRAINT FK_Docente FOREIGN KEY (Cod_docente) REFERENCES Docente(Cod_docente),
	CONSTRAINT FK_REVISORES FOREIGN KEY (Revisores_cod_grupo) REFERENCES Grupo_Revisores (Cod_grupo),
	CONSTRAINT FK_COD_eSTADO FOREIGN KEY (cod_Estado) REFERENCES Estado(cod_estado)
);


CREATE TABLE Categoria(
Cod_categoria int PRIMARY KEY,
Nombre_categoria nvarchar
);

CREATE TABLE Charlas_aceptadas(
	Propuesta_Charla_cod int,
	Cod_categoria int ,
	fecha_hora datetime,
	Duracion int,
	Capacidad_maxima int 

	CONSTRAINT PK_Prouesta_charla PRIMARY KEY (Propuesta_Charla_cod),
	CONSTRAINT FK_PROPUESTA_CHARLA FOREIGN KEY (Propuesta_Charla_cod) REFERENCES Propuesta_Charla(Cod_propuesta),
	CONSTRAINT FK_CATEGORIA FOREIGN KEY (Cod_categoria) REFERENCES Categoria(Cod_categoria)
);


CREATE TABLE Alumno (
	Cod_alumno int PRIMARY KEY,
	Nombre_Alumno nvarchar

);
CREATE TABLE Detalle_Alumno_Charla (
	Charlas_Aceptadas_code int,
	Alumno_cod_alumno int
	CONSTRAINT PK_CHARLAS_ACEPTADAS PRIMARY KEY (Charlas_Aceptadas_code,Alumno_cod_alumno),
	CONSTRAINT FK_ALUMNO FOREIGN KEY (Alumno_cod_alumno) REFERENCES Alumno(Cod_alumno),
	CONSTRAINT FK_CHARLAS_ACEPTADAS FOREIGN KEY (Charlas_Aceptadas_code) REFERENCES Charlas_aceptadas(Propuesta_Charla_cod),
	

);

--EJERCICIO QUERYS 1 Y 2
SELECT U.Cod_universidad,U.Nombre_Universidad,COUNT(*) FROM Universidad U 
							JOIN Docente D ON U.Cod_ciudad=D.Cod_universidad
							JOIN Propuesta_Charla PC ON D.Cod_docente=D.Cod_docente
							GROUP BY U.Cod_universidad,U.Nombre_Universidad HAVING COUNT(D.Cod_docente)>=ALL (SELECT  COUNT(D.Cod_docente) FROM Propuesta_Charla PC JOIN Docente D on PC.Cod_docente=D.Cod_docente GROUP BY PC.Cod_docente)



SELECT DC.Charlas_Aceptadas_code,PC.Nombre_propuesta,COUNT(*) FROM Detalle_Alumno_Charla DC 
					JOIN Alumno A ON DC.Alumno_cod_alumno=A.Cod_alumno
					JOIN Charlas_aceptadas CA ON CA.Propuesta_Charla_cod=DC.Charlas_Aceptadas_code
					JOIN Propuesta_Charla PC ON PC.Cod_propuesta=CA.Propuesta_Charla_cod HAVING COUNT(DC.Charlas_Aceptadas_code) >= ALL(SELECT  COUNT(dc.Charlas_Aceptadas_code) Cantidad FROM Detalle_Alumno_Charla DC GROUP BY DC.Charlas_Aceptadas_code,PC.Nombre_propuesta)
					




SELECT  COUNT(dc.Charlas_Aceptadas_code) Cantidad FROM Detalle_Alumno_Charla DC 
					GROUP BY DC.Charlas_Aceptadas_code
										

SELECT  COUNT(PC.Cod_docente) FROM Propuesta_Charla PC JOIN Docente D on PC.Cod_docente=D.Cod_docente GROUP BY PC.Cod_docente