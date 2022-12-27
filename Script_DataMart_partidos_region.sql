--Delete DataMart
DROP TABLE IF EXISTS WarehousePruebas.resul_de_partidos_por_region;
--create Datamart

CREATE TABLE resul_de_partidos_por_region (
    id_resultado         INTEGER NOT NULL,
    region_id_region     INTEGER NOT NULL,
    partido_id_partido   INTEGER NOT NULL,
    pais_id_pais         INTEGER NOT NULL,
    eleccion_id_eleccion INTEGER NOT NULL
);

--Cargar datos al data mart
INSERT INTO resul_de_partidos_por_region(id_resultado,region_id_region,partido_id_partido,pais_id_pais,eleccion_id_eleccion)

select Resultado.Id_Resultado,Region.ID_Region,Resultado.Id_Partido,Pais.ID_PAIS,Resultado.Id_Eleccion from Resultado 
inner join Municipio on Municipio.ID_Municipio=Resultado.Id_Municipio
inner join Departamento on Municipio.ID_departamento=Departamento.ID_Departamento
inner join Region on Region.ID_Region=Departamento.ID_REGION
inner join Pais on Region.ID_PAIS=Pais.ID_PAIS;