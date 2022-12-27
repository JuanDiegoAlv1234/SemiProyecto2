-- Temporal
CREATE TABLE IF NOT EXISTS `DATAWAREHOUSE`.temporal (
    nombre_eleccion varchar(100),
    anio_eleccion   varchar(100),
    pais            varchar(100),
    region          varchar(100),
    Departamento    varchar(100),
    Municipio       varchar(100),
    Partido         varchar(100),
    Nombre_paritdo  varchar(100),
    Sexo            varchar(100),
    Raza            varchar(100),
    Analfabetos     int,
    Alfabetos       int,
    Primaria        int,
    Nivel_Medio     int,
    Universitarios  int
);

-- DATAWAREHOUSE
USE DATAWAREHOUSE;
create table if not exists `DATAWAREHOUSE`.Pais (
    ID_PAIS  INT AUTO_INCREMENT,
  nombre_pais VARCHAR(100),
  PRIMARY KEY (ID_PAIS)
);

create table if not exists`DATAWAREHOUSE`.Region (
    ID_Region  INT AUTO_INCREMENT,
  nombre_Region VARCHAR(100),
  ID_PAIS INT,
  PRIMARY KEY (ID_Region),
  FOREIGN KEY  (ID_PAIS) REFERENCES  PAIS(ID_PAIS)
);

create table if not exists`DATAWAREHOUSE`. Departamento (
    ID_Departamento  INT AUTO_INCREMENT,
  nombre_Departamento VARCHAR(100),
  ID_REGION INT,
  PRIMARY KEY (ID_Departamento),
  FOREIGN KEY  (ID_REGION) REFERENCES  region (ID_region)
);

create table if not exists`DATAWAREHOUSE`. Municipio (
    ID_Municipio  INT AUTO_INCREMENT,
  nombre_Municipio VARCHAR(100),
  ID_departamento INT,
  PRIMARY KEY (ID_Municipio),
  FOREIGN KEY  (ID_departamento) REFERENCES  departamento (ID_Departamento)
);

create table if not exists`DATAWAREHOUSE`.Partido (
  ID_partido  INT AUTO_INCREMENT,
  Nombre_Partido VARCHAR(100),
  Partido VARCHAR(100),
  ID_Pais INT,
  PRIMARY KEY (ID_partido)
);

create table if not exists `DATAWAREHOUSE`.Eleccion
(
    ID_Eleccion  INT AUTO_INCREMENT,
    AÑO_ELECCION VARCHAR(100),
    TipoEleccion varchar(100),
    id_pais      INT,
    PRIMARY KEY (ID_Eleccion),
    Foreign key (id_pais) references Pais(id_pais)
);

create table if not exists `DATAWAREHOUSE`. Sexo
(
    Id_Sexo   INT AUTO_INCREMENT,
    sexo varchar(100),
    PRIMARY KEY (Id_Sexo)
);
create table if not exists `DATAWAREHOUSE`.Raza
(
    Id_Raza   INT AUTO_INCREMENT,
    RAZA VARCHAR(100),
    PRIMARY KEY (Id_Raza)
);

create table if not exists `DATAWAREHOUSE`.Resultado
(
    Id_Resultado   INT AUTO_INCREMENT,
    Analafabetas   INT,
    Alfabetas      INT,
    Primaria       INT,
    Nivel_Medio    INT,
    Universitarios INT,
    Id_Municipio   INT,
    Id_Eleccion    INT,
    Id_Partido INT ,
    id_raza int, id_Sexo int,
    PRIMARY KEY (Id_Resultado),
    Foreign key (Id_Eleccion) references eleccion (ID_Eleccion),
    Foreign key (Id_Municipio) references municipio (id_municipio),
    Foreign key (Id_Partido) references Partido (id_partido),
    Foreign key (id_Sexo) references sexo (id_sexo),
    Foreign key (Id_raza ) references raza (id_raza)
);


-- DATAMART TIPO DE POBLACIÓN
create table if not exists `DatamartPoblacion`.Partido (
    ID_partido  INT AUTO_INCREMENT,
    Nombre_Partido VARCHAR(100),
    Partido VARCHAR(100),
    PRIMARY KEY (ID_partido)
);
create table if not exists `DatamartPoblacion`.Raza
(
    Id_Raza   INT AUTO_INCREMENT,
    RAZA VARCHAR(100),
    PRIMARY KEY (Id_Raza)
);
create table if not exists `DatamartPoblacion`.Resultado
(
    Id_Resultado   INT AUTO_INCREMENT,
    Analafabetas   INT,
    Primaria       INT,
    Nivel_Medio    INT,
    Universitarios INT,
    Id_Partido INT,
    id_raza INT,
    PRIMARY KEY (Id_Resultado),
    Foreign key (Id_Partido) references Partido(id_partido),
    Foreign key (Id_raza ) references Raza(id_raza)
);

--create Datamart

CREATE TABLE if not exists `DatamartPartidos`.resul_de_partidos_por_region (
    id_resultado         INTEGER NOT NULL,
    region_id_region     INTEGER NOT NULL,
    partido_id_partido   INTEGER NOT NULL,
    pais_id_pais         INTEGER NOT NULL,
    eleccion_id_eleccion INTEGER NOT NULL
);

--Cargar datos al data mart
--
--
-- select Resultado.Id_Resultado,Region.ID_Region,Resultado.Id_Partido,Pais.ID_PAIS,Resultado.Id_Eleccion from `DatamartPartidos`.Resultado
-- inner join Municipio on Municipio.ID_Municipio=Resultado.Id_Municipio
-- inner join Departamento on Municipio.ID_departamento=Departamento.ID_Departamento
-- inner join Region on Region.ID_Region=Departamento.ID_REGION
-- inner join Pais on Region.ID_PAIS=Pais.ID_PAIS;