Insert into DATAWAREHOUSE.Pais(  nombre_pais )
Select distinct  DATAWAREHOUSE.temporal.pais from temporal;



Insert into DATAWAREHOUSE.Region(  nombre_region, id_pais )
Select distinct  DATAWAREHOUSE.temporal.region,DATAWAREHOUSE.Pais.ID_PAIS  from DATAWAREHOUSE.temporal,DATAWAREHOUSE.Pais
where DATAWAREHOUSE.Pais.nombre_pais = DATAWAREHOUSE.temporal.pais;



Insert into DATAWAREHOUSE.Departamento(nombre_Departamento, ID_REGION)
Select distinct DATAWAREHOUSE.temporal.Departamento, DATAWAREHOUSE.Region.ID_REGION
from DATAWAREHOUSE.temporal,
     DATAWAREHOUSE.Region,DATAWAREHOUSE.Pais
where  DATAWAREHOUSE.temporal.pais = DATAWAREHOUSE.Pais.nombre_pais AND DATAWAREHOUSE.Region.ID_PAIS = DATAWAREHOUSE.Pais.ID_PAIS AND DATAWAREHOUSE.Region.nombre_Region= DATAWAREHOUSE.temporal.region
;

Insert into DATAWAREHOUSE.Municipio( nombre_Municipio, ID_departamento)
Select distinct DATAWAREHOUSE.temporal.Municipio,DATAWAREHOUSE.Departamento.ID_DEPARTAMENTO
from DATAWAREHOUSE.temporal,
     DATAWAREHOUSE.Departamento
where  DATAWAREHOUSE.temporal.Departamento= DATAWAREHOUSE.Departamento.nombre_Departamento;


Insert into DATAWAREHOUSE.Partido(  Nombre_Partido, Partido)
Select distinct DATAWAREHOUSE.temporal.Nombre_paritdo,DATAWAREHOUSE.temporal.Partido
from DATAWAREHOUSE.temporal;


Insert into DATAWAREHOUSE.Eleccion( ANIO_ELECCION, TipoEleccion, id_pais )
Select distinct  DATAWAREHOUSE.temporal.anio_eleccion ,DATAWAREHOUSE.temporal.nombre_eleccion,DATAWAREHOUSE.Pais.id_pais
from DATAWAREHOUSE.temporal,DATAWAREHOUSE.Pais
where  DATAWAREHOUSE.temporal.pais=DATAWAREHOUSE.Pais.nombre_pais

;


INSERT INTO DATAWAREHOUSE.Sexo( SEXO) SELECT  DISTINCT  DATAWAREHOUSE.temporal.SEXO FROM DATAWAREHOUSE.temporal;

INSERT INTO DATAWAREHOUSE.Raza( RAZA) SELECT  DISTINCT  DATAWAREHOUSE.temporal.Raza FROM DATAWAREHOUSE.temporal
;
INSERT INTO DATAWAREHOUSE.Resultado(analafabetas, alfabetas, primaria, nivel_medio, universitarios, id_municipio, id_eleccion, id_sexo, id_raza,Id_Partido
                    )
Select DATAWAREHOUSE.temporal.Analfabetos,
       DATAWAREHOUSE.temporal.Alfabetos,
       DATAWAREHOUSE.temporal.Primaria,
       DATAWAREHOUSE.temporal.Nivel_Medio,
       DATAWAREHOUSE.temporal.Universitarios,

       DATAWAREHOUSE.Municipio.ID_Municipio,

       DATAWAREHOUSE.Eleccion.ID_Eleccion,
        s.id_sexo,r.id_raza,p.ID_partido

from DATAWAREHOUSE.temporal
         inner join DATAWAREHOUSE.Pais on DATAWAREHOUSE.temporal.pais = pais.nombre_pais
         inner join DATAWAREHOUSE.Region on DATAWAREHOUSE.temporal.region = region.nombre_Region and region.ID_PAIS = pais.ID_PAIS
         inner join DATAWAREHOUSE.Departamento on Departamento.nombre_Departamento = DATAWAREHOUSE.temporal.Departamento and
                                    DATAWAREHOUSE.Departamento.ID_REGION = region.ID_Region
         inner join DATAWAREHOUSE.Municipio on DATAWAREHOUSE.Municipio.nombre_Municipio = DATAWAREHOUSE.temporal.Municipio and
                                 DATAWAREHOUSE.Departamento.ID_Departamento = DATAWAREHOUSE.Municipio.ID_departamento
         inner join DATAWAREHOUSE.Eleccion
                    on DATAWAREHOUSE.Eleccion.TipoEleccion = DATAWAREHOUSE.temporal.nombre_eleccion and
                       DATAWAREHOUSE.Eleccion.id_pais = pais.ID_PAIS

         inner join DATAWAREHOUSE.Sexo s on DATAWAREHOUSE.temporal.Sexo = s.sexo
         inner join DATAWAREHOUSE.Raza r on DATAWAREHOUSE.temporal.Raza = r.RAZA
          inner join DATAWAREHOUSE.Partido p on DATAWAREHOUSE.temporal.Partido = p.Partido

;
