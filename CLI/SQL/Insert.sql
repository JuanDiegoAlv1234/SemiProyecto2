CALL `DATAWAREHOUSE`.`LoadDataToModel`();

insert into `DatamartPoblacion`.Partido (Nombre_Partido, Partido)
select Nombre_Partido, Partido from `DATAWAREHOUSE`.Partido;

insert into `DatamartPoblacion`.Raza (RAZA)
SELECT RAZA FROM `DATAWAREHOUSE`.Raza;

Insert into `DatamartPoblacion`.Resultado(Analafabetas, Primaria, Nivel_Medio, Universitarios, Id_Partido, id_raza)
select Analafabetas, Primaria, Nivel_Medio, Universitarios,Id_Partido, Id_Raza from `DATAWAREHOUSE`.Resultado;

INSERT INTO `DatamartPartidos`.resul_de_partidos_por_region(id_resultado,region_id_region,partido_id_partido,pais_id_pais,eleccion_id_eleccion)
select Resultado.Id_Resultado,Region.ID_Region,Resultado.Id_Partido,Pais.ID_PAIS,Resultado.Id_Eleccion from Resultado
inner join Municipio on Municipio.ID_Municipio=Resultado.Id_Municipio
inner join Departamento on Municipio.ID_departamento=Departamento.ID_Departamento
inner join Region on Region.ID_Region=Departamento.ID_REGION
inner join Pais on Region.ID_PAIS=Pais.ID_PAIS;


DROP `DATAWAREHOUSE`.TEMPORAL;