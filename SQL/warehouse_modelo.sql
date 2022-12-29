
CREATE DATABASE WarehousePruebas;
use WarehousePruebas;
#----------------------------------------------------------------------------
#iso 8859-1
# TEMPORAL
#----------------------------------------------------------------------------
CREATE TABLE temporal
(
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

Select * from temporal;


#----------------------------------------------------------------------------
#                           MODELO
#----------------------------------------------------------------------------
create table Pais (
    ID_PAIS  INT AUTO_INCREMENT,
    nombre_pais VARCHAR(100),
    PRIMARY KEY (ID_PAIS)
);
create table Region (
    ID_Region  INT AUTO_INCREMENT,
    nombre_Region VARCHAR(100),
    ID_PAIS INT,
    PRIMARY KEY (ID_Region),
    FOREIGN KEY  (ID_PAIS) REFERENCES  Pais(ID_PAIS)
);
create table Departamento (
    ID_Departamento  INT AUTO_INCREMENT,
    nombre_Departamento VARCHAR(100),
    ID_REGION INT,
    PRIMARY KEY (ID_Departamento),
    FOREIGN KEY  (ID_REGION) REFERENCES  Region(ID_region)
);
create table Municipio (
    ID_Municipio  INT AUTO_INCREMENT,
    nombre_Municipio VARCHAR(100),
    ID_departamento INT,
    PRIMARY KEY (ID_Municipio),
    FOREIGN KEY  (ID_departamento) REFERENCES  Departamento(ID_Departamento)
);
create table Partido (
    ID_partido  INT AUTO_INCREMENT,
    Nombre_Partido VARCHAR(100),
    Partido VARCHAR(100),
    ID_Pais INT,
    PRIMARY KEY (ID_partido)
);
create table Eleccion
(
    ID_Eleccion  INT AUTO_INCREMENT,
    AÑO_ELECCION VARCHAR(100),
    TipoEleccion varchar(100),
    id_pais      INT,
    PRIMARY KEY (ID_Eleccion),
    Foreign key (id_pais) references Pais(id_pais)
);
create table Sexo
(
    Id_Sexo   INT AUTO_INCREMENT,
    sexo varchar(100),
    PRIMARY KEY (Id_Sexo)
);
create table Raza
(
    Id_Raza   INT AUTO_INCREMENT,
    RAZA VARCHAR(100),
    PRIMARY KEY (Id_Raza)
);
create table Resultado
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

    Foreign key (Id_Eleccion) references Eleccion(ID_Eleccion),
    Foreign key (Id_Municipio) references Municipio (id_municipio),
    Foreign key (Id_Partido) references Partido(id_partido),
    Foreign key (id_Sexo) references Sexo(id_sexo),
    Foreign key (Id_raza ) references Raza(id_raza)
);


#----------------------------------------------------------------------------
#                       INSERCION DE DATOS
#----------------------------------------------------------------------------
##LLENANDO LA TABLA PAIS 6 PAICES
Insert into Pais(  nombre_pais )
Select distinct  temporal.pais from temporal;
##LLENANDO LA TABLA REGION 22 regiones
Insert into Region(  nombre_region, id_pais )
Select distinct  temporal.region, Pais.ID_PAIS  from temporal, Pais
where Pais.nombre_pais = temporal.pais
;
##LLENANDO LA TABLA DEPARTAMENTOS  81
Insert into Departamento(nombre_Departamento, ID_REGION)
Select distinct temporal.Departamento, Region.ID_REGION
from temporal,
     Region,Pais
where  temporal.pais = Pais.nombre_pais AND Region.ID_PAIS = Pais.ID_PAIS AND Region.nombre_Region= temporal.region
;
##LLENANDO LA TABLA MUNICIPIOS 1170
Insert into Municipio( nombre_Municipio, ID_departamento)
Select distinct temporal.Municipio, Departamento.ID_DEPARTAMENTO
from temporal,
     Departamento
where  temporal.Departamento = Departamento.nombre_Departamento;

##LLENANDO LA TABLA PARTIDO 18
Insert into Partido(  Nombre_Partido, Partido)
Select distinct temporal.Nombre_paritdo,temporal.Partido
from temporal;


##LLENANDO TABLA ELECCION 6
Insert into Eleccion( AÑO_ELECCION, TipoEleccion, id_pais )
Select distinct  temporal.anio_eleccion ,temporal.nombre_eleccion, Pais.id_pais
from temporal, Pais
where  temporal.pais = Pais.nombre_pais
;

##LLENANDO LA TABLA SEXO  2
INSERT INTO Sexo( SEXO) SELECT  DISTINCT  temporal.SEXO FROM temporal;
##LLENANDO LA TABLA RAZA 3 RESULTADOS
INSERT INTO Raza(RAZA) SELECT  DISTINCT  temporal.RAZA FROM temporal;

-- Llenando la tabla    resultados  20970
INSERT INTO Resultado(analafabetas, alfabetas, primaria, nivel_medio, universitarios, id_municipio, id_eleccion, id_sexo, id_raza,Id_Partido
                    )
Select temporal.Analfabetos,
       temporal.Alfabetos,
       temporal.Primaria,
       temporal.Nivel_Medio,
       temporal.Universitarios,
       Municipio.ID_Municipio,
       Eleccion.ID_Eleccion,
        s.id_sexo,r.id_raza,p.ID_partido
from temporal
        inner join Pais on temporal.pais = Pais.nombre_pais
        inner join Region on temporal.region = Region.nombre_Region and Region.ID_PAIS = Pais.ID_PAIS
        inner join Departamento on Departamento.nombre_Departamento = temporal.Departamento and
                                    Departamento.ID_REGION = Region.ID_Region
        inner join Municipio on Municipio.nombre_Municipio = temporal.Municipio and
                                 Departamento.ID_Departamento = Municipio.ID_departamento
        inner join Eleccion
                    on Eleccion.TipoEleccion = temporal.nombre_eleccion and
                       Eleccion.id_pais = Pais.ID_PAIS
        inner join Sexo s on temporal.Sexo = s.sexo
        inner join Raza r on temporal.Raza = r.RAZA
        inner join Partido p on temporal.Partido = p.Partido
;


#----------------------------------------------------------------------------
#                           CONSULTAS
#----------------------------------------------------------------------------
select total1.pais,total1.region , total1.SUMA/total2.nDepartamentos AS TOTALSuma
from (
         select p.nombre_pais                                            pais,
                r.nombre_Region                                          region,

                (sum(Resultado.Alfabetas) + sum(Resultado.Analafabetas)) SUMA
         from Resultado
                  inner join Municipio m on Resultado.Id_Municipio = m.ID_Municipio
                  inner join Departamento d on m.ID_departamento = d.ID_Departamento
                  inner join Region r on d.ID_REGION = r.ID_Region
                  inner join Pais p on r.ID_PAIS = p.ID_PAIS
                  inner join Eleccion e on p.ID_PAIS = e.id_pais
         group by p.nombre_pais, r.nombre_Region
         order by p.nombre_pais) as total1
         inner join
     (
         select Pais.nombre_pais pais , r.nombre_Region region, count(*) as nDepartamentos
         from Pais
                  inner join Region r on Pais.ID_PAIS = r.ID_PAIS
                  inner join Departamento d on r.ID_Region = d.ID_REGION
         group by Pais.nombre_pais, r.nombre_Region, r.nombre_Region
     ) as total2
     on total1.pais= total2.pais and total1.region = total2.region

   order by total1.pais
