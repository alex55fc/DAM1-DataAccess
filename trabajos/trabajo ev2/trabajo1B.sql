insert into PERSONA (DNI, NUMERO_TICKET) values ('11111111A', 1);
insert into PERSONA (DNI, NUMERO_TICKET) values ('22222222B', 2);
insert into PERSONA (DNI, NUMERO_TICKET) values ('33333333C', 3);
insert into PERSONA (DNI, NUMERO_TICKET) values ('44444444D', 4);
insert into PERSONA (DNI, NUMERO_TICKET) values ('55555555E', 5);
insert into PERSONA (DNI, NUMERO_TICKET) values ('66666666F', 6);
insert into PERSONA (DNI, NUMERO_TICKET) values ('77777777G', 7);
insert into PERSONA (DNI, NUMERO_TICKET) values ('11111111H', 8);
insert into PERSONA (DNI, NUMERO_TICKET) values ('22222222J', 9);
insert into PERSONA (DNI, NUMERO_TICKET) values ('33333333K', 10);
insert into PERSONA (DNI, NUMERO_TICKET) values ('44444444L', 11);
insert into PERSONA (DNI, NUMERO_TICKET) values ('55555555M', 12);
insert into PERSONA (DNI, NUMERO_TICKET) values ('66666666N', 13);
insert into PERSONA (DNI, NUMERO_TICKET) values ('77777777O', 14);


insert into ARTISTA (DNI_PERSONA, DIRIGIR_DIRIGE) values ('11111111A', null);
insert into ARTISTA (DNI_PERSONA, DIRIGIR_DIRIGE) values ('22222222B', '11111111A');
insert into ARTISTA (DNI_PERSONA, DIRIGIR_DIRIGE) values ('33333333C', '11111111A');
insert into ARTISTA (DNI_PERSONA, DIRIGIR_DIRIGE) values ('44444444D', '11111111A');
insert into ARTISTA (DNI_PERSONA, DIRIGIR_DIRIGE) values ('55555555E', '11111111A');
insert into ARTISTA (DNI_PERSONA, DIRIGIR_DIRIGE) values ('77777777G', '11111111A');
insert into ARTISTA (DNI_PERSONA, DIRIGIR_DIRIGE) values ('11111111H', '11111111A');


insert into CLIENTE (DNI_CLIENTE) values ('22222222J');
insert into CLIENTE (DNI_CLIENTE) values ('33333333K');
insert into CLIENTE (DNI_CLIENTE) values ('44444444L');
insert into CLIENTE (DNI_CLIENTE) values ('55555555M');
insert into CLIENTE (DNI_CLIENTE) values ('66666666N');
insert into CLIENTE (DNI_CLIENTE) values ('77777777O');


insert into MUSEO (ID_MUSEO, CODIGO_POSTAL, CALLE) values (111111,5001, 'Paseo de la Fama' );
insert into MUSEO (ID_MUSEO, CODIGO_POSTAL, CALLE) values (123456,5002, 'La Rambla, Barcelona');
insert into MUSEO (ID_MUSEO, CODIGO_POSTAL, CALLE) values (222222,5003, 'Orchard Road, Singapur');
insert into MUSEO (ID_MUSEO, CODIGO_POSTAL, CALLE) values (333333,5004, 'Khao San, Bangkok');
insert into MUSEO (ID_MUSEO, CODIGO_POSTAL, CALLE) values (444444,5010, 'Wall Street, Nueva York');
insert into MUSEO (ID_MUSEO, CODIGO_POSTAL, CALLE) values (555555,5011, 'Vía Dolorosa, Jerusalén');
insert into MUSEO (ID_MUSEO, CODIGO_POSTAL, CALLE) values (666666,5012, 'Las Vegas Strip, Vegas');


insert into OBRA (ID_OBRA, FECHA_CREACION,GENERO, NOMBRE_CREACION, DNI_ARTISTA, DNI_CLIENTE1, ID_MUSEO1) values (1111,'01-01-2000','Terror', 'Dia terror', '11111111A','22222222J',111111 ); 
insert into OBRA (ID_OBRA, FECHA_CREACION, NOMBRE_CREACION, DNI_ARTISTA, DNI_CLIENTE1, ID_MUSEO1) values (2222,'02-01-2000','Dia drama', '11111111A','22222222J',123456 );
insert into OBRA (ID_OBRA, FECHA_CREACION, NOMBRE_CREACION, DNI_ARTISTA, DNI_CLIENTE1, ID_MUSEO1) values (3333,'03-01-2000','Noche drama', '22222222B','33333333K',222222 ); 
insert into OBRA (ID_OBRA, FECHA_CREACION, NOMBRE_CREACION, DNI_ARTISTA, DNI_CLIENTE1, ID_MUSEO1) values (4444,'04-01-2000','Noche mala', '33333333C','33333333K',222222 ); 
insert into OBRA (ID_OBRA, FECHA_CREACION, NOMBRE_CREACION, DNI_ARTISTA, DNI_CLIENTE1, ID_MUSEO1) values (5555,'05-01-2000','Noche cara', '33333333C','33333333K',333333 ); 
insert into OBRA (ID_OBRA, FECHA_CREACION,GENERO, NOMBRE_CREACION, DNI_ARTISTA, DNI_CLIENTE1, ID_MUSEO1) values (6666,'06-01-2000','Animacion', 'Casa loca', '44444444D','44444444L',333333 ); 
insert into OBRA (ID_OBRA, FECHA_CREACION,GENERO, NOMBRE_CREACION, DNI_ARTISTA, DNI_CLIENTE1, ID_MUSEO1) values (7777,'07-01-2000','Animacion', 'Casa loca', '55555555E','44444444L',444444 ); 
insert into OBRA (ID_OBRA, FECHA_CREACION,GENERO, NOMBRE_CREACION, DNI_ARTISTA, DNI_CLIENTE1, ID_MUSEO1) values (8888,'08-01-2000','Terror', 'Casa mala', '77777777G','55555555M',444444 ); 
insert into OBRA (ID_OBRA, FECHA_CREACION,GENERO, NOMBRE_CREACION, DNI_ARTISTA, DNI_CLIENTE1, ID_MUSEO1) values (9999,'09-01-2000','Horror', 'Maldicion', '77777777G','66666666N',555555 ); 
insert into OBRA (ID_OBRA, FECHA_CREACION,GENERO, NOMBRE_CREACION, DNI_ARTISTA, DNI_CLIENTE1, ID_MUSEO1) values (1010,'01-10-2000','Terror', 'Casa pobre', '77777777G','66666666N',666666 ); 
insert into OBRA (ID_OBRA, FECHA_CREACION,GENERO, NOMBRE_CREACION, DNI_ARTISTA, DNI_CLIENTE1, ID_MUSEO1) values (1011,'02-10-2000','Terror', 'Casa', '77777777G','77777777O',666666 ); 

insert into ESTILO (NOMBRE_ESTILO, AÑO_CREACION) values ('Realismo',1840);
insert into ESTILO (NOMBRE_ESTILO, AÑO_CREACION) values ('Fotorrealismo',1960);
insert into ESTILO (NOMBRE_ESTILO, AÑO_CREACION) values ('Expresionismo',1911);
insert into ESTILO (NOMBRE_ESTILO, AÑO_CREACION) values ('Impresionismo',1874);
insert into ESTILO (NOMBRE_ESTILO, AÑO_CREACION) values ('Abstracto',1910);
insert into ESTILO (NOMBRE_ESTILO, AÑO_CREACION) values ('Surrealismo',1924);
insert into ESTILO (NOMBRE_ESTILO, AÑO_CREACION) values ('Arte pop',1975);

insert into TIENE(NOMBRE_ESTILO1, DNI_PERSONA) values ('Realismo','11111111A');
insert into TIENE(NOMBRE_ESTILO1, DNI_PERSONA) values ('Realismo','22222222B');
insert into TIENE(NOMBRE_ESTILO1, DNI_PERSONA) values ('Fotorrealismo','33333333C');
insert into TIENE(NOMBRE_ESTILO1, DNI_PERSONA) values ('Expresionismo','33333333C');
insert into TIENE(NOMBRE_ESTILO1, DNI_PERSONA) values ('Impresionismo','44444444D');
insert into TIENE(NOMBRE_ESTILO1, DNI_PERSONA) values ('Impresionismo','55555555E');
insert into TIENE(NOMBRE_ESTILO1, DNI_PERSONA) values ('Abstracto','55555555E');
insert into TIENE(NOMBRE_ESTILO1, DNI_PERSONA) values ('Surrealismo','77777777G');
insert into TIENE(NOMBRE_ESTILO1, DNI_PERSONA) values ('Arte pop','11111111H');



--UD06 Consultas basicas 
/*Consulta A: muestra todo de las obras que empiece por 'No'
Explicacion: haceqque nos muestre todo de la tabla obrea del el nomhbre_creacion empiece por 'No' y con %  con lo que continue despuesdel 'No'
con un operador like */
select * from  OBRA where NOMBRE_CREACION like 'No%';

/*Consulta B: muestra en orden descendente de fecha_creacion la Id_obra , Fecha_creacion y _ nombre_creacion  cuando el DNI_CLIENTE empiece por 4 y el NOMBRE_CREACION empiece por C
Explicacion: hacemos que nos muestre los datos de obra donde con el operador and poenmos varias restriccionesa la consulta y luego con un 
operadororder by ' ' deschacmeos que nos ordeneen orden descencente de fecha_creacion*/
select ID_OBRA, FECHA_CREACION, NOMBRE_CREACION from OBRA where DNI_CLIENTE1 like '4%' and NOMBRE_CREACION like 'C%' order by FECHA_CREACION desc;

/*Consulta C: muestra todo de ESTILO donde el NOMBRE_estilo este en año_creacion sea 1910 y 1975.
Explicacion:hacemos que nos muestre todo de la tabla estilo donde por medio de una subconsulta hacemos que el año de creacion sea 1910 o 1975 con un in */
select * from ESTILO where NOMBRE_ESTILO in
(select NOMBRE_ESTILO from ESTILO where AÑO_CREACION in (1910, 1975));

/*Consulta D: muestra todo de la tabla museo que tenga el codigo postal mas alto de las calles que empiecen por La
Explicacion: por medio de un all seleccionarmos todos los datos de la tabla museo donde el codigo postal sea el mayor  y que la calle empiece
por 'La' con un operador like */
select * from MUSEO where CODIGO_POSTAL >= ALL (select CODIGO_POSTAL from MUSEO where CALLE like 'La%');

/*Consulta E: muestra el dni de los artistas y el nombre del estilo sea 'realimmos' , 'impresionismo' o 'surrealismo' .
Explicacion: por medio de un join on realcimnamos el dni_persona(Artista) con el Dni_persona(tiene) y usamos otro joino on
pero esta vez realcionamos  el nombre_estilo(tiene) con nombre_estil(estilo) donde el nombre_estilo sea'realismo' impresionismo' o 'surrealismo'*/
select A.DNI_PERSONA , E.NOMBRE_ESTILO from ARTISTA A join TIENE T on( A.DNI_PERSONA =  T.DNI_PERSONA) 
join ESTILO E on(T.NOMBRE_ESTILO1 = E.NOMBRE_ESTILO)where NOMBRE_ESTILO in ('Realismo', 'Impresionismo', 'Surrealismo') ;

/*Consulta F: muestra todo de los artistas que tienen como estilo 'realismo' */
select * from ARTISTA where dni_persona in(
select dni_persona from tiene where nombre_estilo1 in(
select nombre_estilo from estilo where nombre_estilo like 'Realismo'));

/*Consulta G: muestra todo de artistas donde el genero de la obra sea 'Animacion' y  se creo el siete de enero del 2000  */
select *
from artista
where(
    DNI_PERSONA in (
        SELECT DNI_ARTISTA
        from obra 
        where genero = 'Animacion'
    )
)
and(
    DNI_PERSONA in (
        select DNI_ARTISTA
        from obra 
        where FECHA_CREACION = '07-01-2000'
    )

);
/*Consulta H :muestra el identificador de museo y el identificador de la obra e
Explicacion: concatenamos dos tablas, museo y obra con un join on que nos realciona el Id_museo de muso con el Id_museo1 de obra y nos muestra
las tablas id_museo e id_obra en pantalla
Apuntes: JOIN on sirve para concatenar columnas de tablas que tienen el primary key en comun pero con nombre distinto*/
select M.ID_MUSEO , O.ID_OBRA from museo M JOIN OBRA O on (M.ID_MUSEO = O.ID_MUSEO1);

/*Consulta I: muestra en una sola columna con concatenacion de texto los artistas y el nombre de sus obras.
Explicacion: por medio de una concatenacion de textos hacemos una unica columna donde nos realciona el Dni_persona de artista y el Nombre_creacion de Obra
moatrando el dni_persona, un texto que escribimos nosotros para dar sentido a la consulta que hacemos y el nombre_creacion con el titulo de la columna
usando un as para escribir nosotros el titulo de dicha columna.
Apuntes :concatenacion de texto entre las tablas que se relacionan ponemos el texto del medio con || '' ||
, luego con un as ponemos el nombre de la tabla de arriba entre comillas "" luego un join NORMAL ya que relacianmosdatos en comun con primary key
*/
select A.DNI_PERSONA ||' creo la obra con nombre: ' || O.NOMBRE_CREACION as "Artistas y sus obras" from artista a join obra o on(A.DNI_PERSONA = O.DNI_ARTISTA);

/*Consulta J: muestra todo de obra dona la fecha no este entre el 3 y el 7 de enero del 200*/
select * from OBRA where GENERO not in (
    select GENERO from obra where FECHA_CREACION between '03-01-2000' and '07-01-2000');
    
--UD07 consultas avanzadas 
/*Consulta A: muestra el genero e id_museo agrupados por genero e id_museo */
SELECT GENERO, ID_MUSEO1
FROM OBRA
GROUP BY GENERO, ID_MUSEO1;
/*Consulta B: muestra la cantidad de artistas con un tabla llamada numero_artistas que tienen el estilo impresionismo */
SELECT COUNT(A.DNI_PERSONA) as numero_artistas
FROM ARTISTA A  
JOIN TIENE T ON A.DNI_PERSONA = T.DNI_PERSONA
WHERE T.NOMBRE_ESTILO1 = 'Impresionismo';

/* Consulta C: muestra el dni del artista y cliente que  su id obra sea superior a 6666 agrupados   */
select DNI_ARTISTA, DNI_CLIENTE1
from OBRA 
where ID_OBRA > 6666
group by DNI_ARTISTA, DNI_CLIENTE1;

/*Consulta D: muestra el id_museo y la cantidad de obras si tiene el museo mas de 1 obra registrada */
SELECT ID_MUSEO1, COUNT(id_obra)
FROM OBRA
GROUP BY ID_MUSEO1
HAVING COUNT(id_obra) > 1;

/*Consulta E: muestra el genero de la obra y si aparece mas de 2 veces la cantidad de veces que este genero aparece en obras despues del 2 de enero del 2000 */
select GENERO, count (genero) 
from obra 
where dni_artista in(
    select dni_artista 
    from obra 
    where FECHA_CREACION > '02-01-2000'
)
group by GENERO
having count(genero) > 2;


/*Consulta f: muestra el dni del artista 11111111A y la cantidad de obras registradas si tiene mas de 1 obra*/
select  dni_artista, count(id_obra) 
from obra
where dni_artista = '11111111A'
group by dni_artista
having count(id_obra) > 1;

/*Consulta G: muestra el dni del artista su ticket y el id de la obra donde la fecha de creacion sea los 3 con el mayor dia de creacion*/
select * from(
select o.dni_artista,o.id_obra, p.numero_ticket
from obra o inner join persona p on o.dni_artista = p.dni
order by o.FECHA_CREACION asc
) 
where rownum <= 3;

/*Consulta H: muestra el dni_persona de artista y tiene donde el dni de artista sea '11111111A'  y el nombre del estilo sea Impresionismo*/
select dni_persona 
from artista 
where dni_persona = '11111111A'
UNION 
select dni_persona 
from tiene
where NOMBRE_ESTILO1 = 'Impresionismo';

/*Consulta I: muestra los dni de artista donde los artistas tengan una obra donde el genero de la obra sea 'Terror'*/
select dni_persona 
from artista 
INTERSECT 
select dni_artista 
from obra 
where GENERO = 'Terror';

/*Consulta J: muestra el dni de los artistas de obras que no tienen el estilo 'Realismo' o 'Surrealismo' en la tabla tiene */
select dni_artista 
from obra 
MINUS
select dni_persona 
from tiene 
where nombre_estilo1 in ('Realismo','Surrealismo' );
