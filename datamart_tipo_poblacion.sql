create database DatamartPoblacion;
##
    
    
#    Tiene que llevar ese orden de creación e inserción, sino, truena xd


##

#----------------------------------------------------------------------------
#                   TABLAS DATAMART TIPO DE POBLACIÓN
#----------------------------------------------------------------------------
create table Partido (
    ID_partido  INT AUTO_INCREMENT,
    Nombre_Partido VARCHAR(100),
    Partido VARCHAR(100),
    PRIMARY KEY (ID_partido)
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
    Primaria       INT,
    Nivel_Medio    INT,
    Universitarios INT,
    Id_Partido INT,
    id_raza INT,
    PRIMARY KEY (Id_Resultado),
    Foreign key (Id_Partido) references Partido(id_partido),
    Foreign key (Id_raza ) references Raza(id_raza)
);



#----------------------------------------------------------------------------
#                  CONSULTAS DESDE EL DATA WAREHOUSE
#----------------------------------------------------------------------------

##DATOS PARA TABLA PARTIDO
select Nombre_Partido, Partido from Partido;

##DATOS PARA TABLA RAZA
select RAZA from Raza;

##DATOS PARA TABLA RESULTADO
select Analafabetas, Primaria, Nivel_Medio, Universitarios,Id_Partido, Id_Raza from  Resultado;



