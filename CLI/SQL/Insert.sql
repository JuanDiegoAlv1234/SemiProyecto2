CALL `DATAWAREHOUSE`.`LoadDataToModel`();

insert into Partido (Nombre_Partido, Partido)
select Nombre_Partido, Partido from Partido;

##DATOS PARA TABLA RAZA
insert into Raza (RAZA)
SELECT RAZA FROM Raza;

##DATOS PARA TABLA RESULTADO
Insert into Resultado(Analafabetas, Primaria, Nivel_Medio, Universitarios, Id_Partido, id_raza)
select Analafabetas, Primaria, Nivel_Medio, Universitarios,Id_Partido, Id_Raza from  Resultado;


select r.Id_r,r2.ID_Region,r.Id_Partido,p.ID_PAIS,r.Id_Eleccion from `DatamartPartidos`.Resultado r
inner join `DatamartPartidos`.Municipio m on m.ID_m=r.Id_m
inner join `DatamartPartidos`.Departamento d on m.ID_departamento=d.ID_Departamento
inner join `DatamartPartidos`.Region r2 on r2.ID_Region=d.ID_REGION
inner join `DatamartPartidos`.Pais p on r2.ID_PAIS=p.ID_PAIS
INSERT INTO `DatamartPartidos`.resul_de_partidos_por_region(id_r,region_id_region,partido_id_partido,pais_id_pais,eleccion_id_eleccion)