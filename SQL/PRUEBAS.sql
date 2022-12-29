use DATAWAREHOUSE;
    select p.nombre_Pais                                            Pais,
                    d.nombre_Departamento                                          Departamento,
                    Sexo.Sexo Sexo,

                    (sum(Resultado.Universitarios)) SUMA
             from     Sexo inner join Resultado on Resultado.id_Sexo=Sexo.Id_Sexo
                      inner join Municipio m on Resultado.Id_Municipio = m.ID_Municipio
                      inner join Departamento d on m.ID_Departamento = d.ID_Departamento
                      inner join Region r on d.ID_Region = r.ID_Region
                      inner join Pais p on r.ID_Pais = p.ID_Pais
                      inner join Eleccion e on p.ID_Pais = e.id_Pais
               where Sexo.Sexo='mujeres'

             group by p.nombre_Pais, d.nombre_Departamento,Sexo.Sexo
             order by p.nombre_pais;

use DATAWAREHOUSE;
select p.nombre_Pais                                            Pais,
                d.nombre_Departamento                                          Departamento,
                Sexo.Sexo Sexo,

                (sum(Resultado.Universitarios)) SUMA
         from     Sexo inner join Resultado on Resultado.id_Sexo=Sexo.Id_Sexo
                  inner join Municipio m on Resultado.Id_Municipio = m.ID_Municipio
                  inner join Departamento d on m.ID_Departamento = d.ID_Departamento
                  inner join Region r on d.ID_Region = r.ID_Region
                  inner join Pais p on r.ID_Pais = p.ID_Pais
                  inner join Eleccion e on p.ID_Pais = e.id_Pais
           where Sexo.Sexo='hombres'

         group by p.nombre_Pais, d.nombre_Departamento,Sexo.Sexo
         order by p.nombre_pais;
