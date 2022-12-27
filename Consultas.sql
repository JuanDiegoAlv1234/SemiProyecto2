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

use DATAWAREHOUSE;
select total1.Pais,total1.Region , total1.SUMA/total2.nDepartamentos as PromedioVotos
from (
         select p.nombre_Pais                                            Pais,
                r.nombre_Region                                          Region,

                (sum(Resultado.Alfabetas) ) SUMA
         from Resultado
                  inner join Municipio m on Resultado.Id_Municipio = m.ID_Municipio
                  inner join Departamento d on m.ID_Departamento = d.ID_Departamento
                  inner join Region r on d.ID_Region = r.ID_Region
                  inner join Pais p on r.ID_Pais = p.ID_Pais
                  inner join Eleccion e on p.ID_Pais = e.id_Pais

         group by p.nombre_Pais, r.nombre_Region
         order by p.nombre_Pais) as total1
         inner join

     (
         select Pais.nombre_Pais Pais , r.nombre_Region Region, count(*) as nDepartamentos
         from Pais
                  inner join Region r on Pais.ID_Pais = r.ID_Pais
                  inner join Departamento d on r.ID_Region = d.ID_Region
         group by Pais.nombre_Pais, r.nombre_Region
     ) as total2

     on total1.Pais= total2.Pais and total1.Region = total2.Region

   order by total1.Pais;

use DATAWAREHOUSE;

select total1.Pais,total1.Region , total1.SUMA/total2.nDepartamentos as PromedioVotos
from (
         select p.nombre_Pais                                            Pais,
                r.nombre_Region                                          Region,

                (sum(Resultado.Analafabetas) ) SUMA
         from Resultado
                  inner join Municipio m on Resultado.Id_Municipio = m.ID_Municipio
                  inner join Departamento d on m.ID_Departamento = d.ID_Departamento
                  inner join Region r on d.ID_Region = r.ID_Region
                  inner join Pais p on r.ID_Pais = p.ID_Pais
                  inner join Eleccion e on p.ID_Pais = e.id_Pais

         group by p.nombre_Pais, r.nombre_Region
         order by p.nombre_Pais) as total1
         inner join

     (
         select Pais.nombre_Pais Pais , r.nombre_Region Region, count(*) as nDepartamentos
         from Pais
                  inner join Region r on Pais.ID_Pais = r.ID_Pais
                  inner join Departamento d on r.ID_Region = d.ID_Region
         group by Pais.nombre_Pais, r.nombre_Region
     ) as total2

     on total1.Pais= total2.Pais and total1.Region = total2.Region

   order by total1.Pais;
use DATAWAREHOUSE;

select total1.Pais,total1.SUMA AS MUJERES_ANALFABETAS  from (

select p.nombre_Pais                                            Pais,


            s.Sexo,
             ( sum(Resultado.Alfabetas)) SUMA
      FROM Raza
               inner join Resultado on Raza.Id_Raza = Resultado.id_Raza

               inner join Municipio m on Resultado.Id_Municipio = m.ID_Municipio
               inner join Departamento d on m.ID_Departamento = d.ID_Departamento
               inner join Region r on d.ID_Region = r.ID_Region
               inner join Pais p on r.ID_Pais = p.ID_Pais
               inner join Sexo s on Resultado.id_Sexo = s.Id_Sexo
    where s.Sexo='mujeres'

      group by p.nombre_Pais,s.Sexo
      order by p.nombre_Pais) as total1 ,


(

select p.nombre_Pais                                            Pais,


             ( sum(Resultado.Alfabetas)+sum(Resultado.Analafabetas)) SUMA
      FROM Raza
               inner join Resultado on Raza.Id_Raza = Resultado.id_Raza

               inner join Municipio m on Resultado.Id_Municipio = m.ID_Municipio
               inner join Departamento d on m.ID_Departamento = d.ID_Departamento
               inner join Region r on d.ID_Region = r.ID_Region
               inner join Pais p on r.ID_Pais = p.ID_Pais
               inner join Sexo s on Resultado.id_Sexo = s.Id_Sexo


      group by p.nombre_Pais
      order by p.nombre_Pais) as total2
WHERE total1.Pais=total2.Pais;

use DATAWAREHOUSE;
select total1.Pais,total1.SUMA AS MUJERES_ANALFABETAS  from (

select p.nombre_Pais                                            Pais,


            s.Sexo,
             ( sum(Resultado.Alfabetas)) SUMA
      FROM Raza
               inner join Resultado on Raza.Id_Raza = Resultado.id_Raza

               inner join Municipio m on Resultado.Id_Municipio = m.ID_Municipio
               inner join Departamento d on m.ID_Departamento = d.ID_Departamento
               inner join Region r on d.ID_Region = r.ID_Region
               inner join Pais p on r.ID_Pais = p.ID_Pais
               inner join Sexo s on Resultado.id_Sexo = s.Id_Sexo
    where s.Sexo='hombres'

      group by p.nombre_Pais,s.Sexo
      order by p.nombre_Pais) as total1 ,


(

select p.nombre_Pais                                            Pais,


             ( sum(Resultado.Alfabetas)+sum(Resultado.Analafabetas)) SUMA
      FROM Raza
               inner join Resultado on Raza.Id_Raza = Resultado.id_Raza

               inner join Municipio m on Resultado.Id_Municipio = m.ID_Municipio
               inner join Departamento d on m.ID_Departamento = d.ID_Departamento
               inner join Region r on d.ID_Region = r.ID_Region
               inner join Pais p on r.ID_Pais = p.ID_Pais
               inner join Sexo s on Resultado.id_Sexo = s.Id_Sexo


      group by p.nombre_Pais
      order by p.nombre_Pais) as total2
WHERE total1.Pais=total2.Pais;


use DATAWAREHOUSE;
select total1.Pais, total1.SUMA*100/total2.SUMA  AS PORCENTAJE  from (

select p.nombre_Pais                                            Pais,


            s.Sexo,
             ( sum(Resultado.Alfabetas)) SUMA
      FROM Raza
               inner join Resultado on Raza.Id_Raza = Resultado.id_Raza

               inner join Municipio m on Resultado.Id_Municipio = m.ID_Municipio
               inner join Departamento d on m.ID_Departamento = d.ID_Departamento
               inner join Region r on d.ID_Region = r.ID_Region
               inner join Pais p on r.ID_Pais = p.ID_Pais
               inner join Sexo s on Resultado.id_Sexo = s.Id_Sexo
    where s.Sexo='mujeres'

      group by p.nombre_Pais,s.Sexo
      order by p.nombre_Pais) as total1 ,


(

select p.nombre_Pais                                            Pais,


             ( sum(Resultado.Alfabetas)+sum(Resultado.Analafabetas)) SUMA
      FROM Raza
               inner join Resultado on Raza.Id_Raza = Resultado.id_Raza

               inner join Municipio m on Resultado.Id_Municipio = m.ID_Municipio
               inner join Departamento d on m.ID_Departamento = d.ID_Departamento
               inner join Region r on d.ID_Region = r.ID_Region
               inner join Pais p on r.ID_Pais = p.ID_Pais
               inner join Sexo s on Resultado.id_Sexo = s.Id_Sexo


      group by p.nombre_Pais
      order by p.nombre_Pais) as total2
WHERE total1.Pais=total2.Pais ;
use DATAWAREHOUSE;

select total1.Pais, total1.SUMA*100/total2.SUMA  AS PORCENTAJE  from (

select p.nombre_Pais                                            Pais,


            s.Sexo,
             ( sum(Resultado.Alfabetas)) SUMA
      FROM Raza
               inner join Resultado on Raza.Id_Raza = Resultado.id_Raza

               inner join Municipio m on Resultado.Id_Municipio = m.ID_Municipio
               inner join Departamento d on m.ID_Departamento = d.ID_Departamento
               inner join Region r on d.ID_Region = r.ID_Region
               inner join Pais p on r.ID_Pais = p.ID_Pais
               inner join Sexo s on Resultado.id_Sexo = s.Id_Sexo
    where s.Sexo='hombres'

      group by p.nombre_Pais,s.Sexo
      order by p.nombre_Pais) as total1 ,


(

select p.nombre_Pais                                            Pais,


             ( sum(Resultado.Alfabetas)+sum(Resultado.Analafabetas)) SUMA
      FROM Raza
               inner join Resultado on Raza.Id_Raza = Resultado.id_Raza

               inner join Municipio m on Resultado.Id_Municipio = m.ID_Municipio
               inner join Departamento d on m.ID_Departamento = d.ID_Departamento
               inner join Region r on d.ID_Region = r.ID_Region
               inner join Pais p on r.ID_Pais = p.ID_Pais
               inner join Sexo s on Resultado.id_Sexo = s.Id_Sexo


      group by p.nombre_Pais
      order by p.nombre_Pais) as total2
WHERE total1.Pais=total2.Pais;


use DATAWAREHOUSE;
select
    total1.Pais,
    total1.nombre_Departamento,
    total1.suma
from (
        select
            p.nombre_Pais Pais,
            d.nombre_Departamento, (
                sum(Resultado.Alfabetas) + sum(Resultado.Analafabetas)
            ) SUMA
        from Resultado
            inner join Municipio m on Resultado.Id_Municipio = m.ID_Municipio
            inner join Departamento d on m.ID_Departamento = d.ID_Departamento
            inner join Region r on d.ID_Region = r.ID_Region
            inner join Pais p on r.ID_Pais = p.ID_Pais
        where
            nombre_Pais = 'GUATEMALA'
        group by
            p.nombre_Pais,
            d.nombre_Departamento
        order by
            p.nombre_Pais
    ) as total1, (
        select
            p.nombre_Pais Pais,
            d.nombre_Departamento, (
                sum(Resultado.Alfabetas) + sum(Resultado.Analafabetas)
            ) SUMA
        from Resultado
            inner join Municipio m on Resultado.Id_Municipio = m.ID_Municipio
            inner join Departamento d on m.ID_Departamento = d.ID_Departamento
            inner join Region r on d.ID_Region = r.ID_Region
            inner join Pais p on r.ID_Pais = p.ID_Pais
        where
            nombre_Pais = 'GUATEMALA'
            and nombre_Departamento = 'Guatemala'
        group by
            p.nombre_Pais,
            d.nombre_Departamento
        order by
            p.nombre_Pais
    ) as total2

order by total1.nombre_Departamento;
use DATAWAREHOUSE;

select
    total1.Pais,
    total1.nombre_Departamento,
    total1.suma
from (
        select
            p.nombre_Pais Pais,
            d.nombre_Departamento, (
                sum(Resultado.Alfabetas) + sum(Resultado.Analafabetas)
            ) SUMA
        from Resultado
            inner join Municipio m on Resultado.Id_Municipio = m.ID_Municipio
            inner join Departamento d on m.ID_Departamento = d.ID_Departamento
            inner join Region r on d.ID_Region = r.ID_Region
            inner join Pais p on r.ID_Pais = p.ID_Pais
        where
            nombre_Pais = 'Costa Rica'
        group by
            p.nombre_Pais,
            d.nombre_Departamento
        order by
            p.nombre_Pais
    ) as total1, (
        select
            p.nombre_Pais Pais,
            d.nombre_Departamento, (
                sum(Resultado.Alfabetas) + sum(Resultado.Analafabetas)
            ) SUMA
        from Resultado
            inner join Municipio m on Resultado.Id_Municipio = m.ID_Municipio
            inner join Departamento d on m.ID_Departamento = d.ID_Departamento
            inner join Region r on d.ID_Region = r.ID_Region
            inner join Pais p on r.ID_Pais = p.ID_Pais
        where
            nombre_Pais = 'Costa Rica'
            and nombre_Departamento = 'Heredia'
        group by
            p.nombre_Pais,
            d.nombre_Departamento
        order by
            p.nombre_Pais
    ) as total2

order by total1.nombre_Departamento;
