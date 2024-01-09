--Apartado a
--base de datos 
drop table socio cascade constraints;
drop table asociacion cascade constraints;
drop table pais cascade constraints;
drop table localizacion cascade constraints;
drop table proyecto cascade constraints;
drop table pertenece cascade constraints;

create table socio (
DNI varchar2(9) primary key,
nombre varchar2(15),
direccion varchar2(20)
);
create table asociacion(
cif varchar2(12) primary key,
nombre varchar2(20),
tipo varchar2(15)
);

create table pais(
codigo varchar2(9) primary key,
nombre varchar2(15)
);

create table localizacion(
numero_loc number(9) primary key,
ciudad varchar2(15),
codigo_pais varchar2(9) not null,

constraint codigo_pais_fk foreign key (codigo_pais)
    references pais(codigo) on delete cascade
);

create table proyecto (
id_pro varchar2(9) primary key,
nombre varchar2(15),
presupuesto number(2,2),

cif_asociacion varchar2(12) not null,
id_superproyecto varchar2(9),
numero_loc number(9) not null,
    constraint cif_asociacion_fk foreign key(cif_asociacion)
        references asociacion(cif) on delete cascade ,
    constraint numero_loc_fk foreign key(numero_loc)
        references localizacion(numero_loc)on delete cascade,
    constraint id_superproyecto_fk foreign key (id_superproyecto)
        references proyecto(id_pro) on delete cascade
);

create table pertenece (
fecha_alta date,
aportacion_inicial number,
cuota number,

cif_asociacion varchar2(12),
dni_socio varchar2(9),
    constraint pertenece_pk primary key(cif_asociacion, dni_socio),
    constraint cif_asociacion1_fk foreign key(cif_asociacion)
        references asociacion(cif) on delete cascade,
    constraint dni_socio_fk foreign key(dni_socio)
        references socio(DNI) on delete cascade
);
--apartado B
--I)
alter table pertenece modify fecha_alta default sysdate;
alter table pertenece modify  aportacion_inicial default 100;
alter table pertenece modify cuota default 25;
--II)
alter table asociacion add constraint asociacio_ck check(tipo in ('SL', 'SA', 'SADL', 'Gubernamental'));
--III)
alter table proyecto add constraint proyecto_ck check(presupuesto >= 0);
--IV)
alter table localizacion add constraint localizacion_ck check(ciudad is not null);
alter table pais add constraint pais_ck check(nombre is not null);
--V)
--Adjuntado en el word

--apartado C
--I)
insert into socio values ('12345678X' ,'Bill Gates',' Calle Falsa 123');
insert into socio (DNI,nombre)  values ('36925814R' ,'Ellon Musk');
insert into socio values ('78945612A' ,'Jeff Bezos','  Amazon HQ ');

--II)
insert into asociacion values('777444111Z', 'ICT for the People', 'SA');
insert into asociacion values('666666666P', 'GreenPeace', 'SADL');

--III)
insert into pais values('1','España');
insert into pais values('2','EEUU');
insert into pais values('3','Alemania');

--IV)
insert into localizacion  values (1, 'Madrid', '1');
insert into localizacion  values (2, 'Barcelona', '1');
insert into localizacion  values (3, 'Zaragoza', '1');
insert into localizacion  values (4, 'Nueva York', '2');
insert into localizacion  values (5, 'Boston', '2');
insert into localizacion  values (6, 'Seattle', '2');
insert into localizacion  values (7, 'Munich', '3');
insert into localizacion  values (8, 'Hamburgo', '3');
insert into localizacion  values (9, 'Berlín', '3');

--V) copiado en clase, da errores sera algun tipo de dato o algo 
insert into proyecto (id_pro, nombre, presupuesto, cif_asociacion, id_superproyecto,numero_loc)
    values (1, 'Top secret', null, '777444111Z', null, 4);
insert into proyecto (id_pro, nombre, presupuesto, cif_asociacion, id_superproyecto,numero_loc)
    values (2, 'Fibra para todos', 10000, '777444111Z', 1, 3);
insert into proyecto (id_pro, nombre, presupuesto, cif_asociacion, id_superproyecto,numero_loc)
    values (3, 'Gaanaderia sostenible', 50000, '666666666P', null, 5);
insert into proyecto (id_pro, nombre, presupuesto, cif_asociacion, id_superproyecto,numero_loc)
    values (4, 'Com seg', 25000, '777444111Z', 1, 7);
insert into proyecto (id_pro, nombre, presupuesto, cif_asociacion, id_superproyecto,numero_loc)
    values (5, 'Agri-cultura', 75000, '666666666P', null, 2);
insert into proyecto (id_pro, nombre, presupuesto, cif_asociacion, id_superproyecto,numero_loc)
    values (6, 'Ciberseg', 15000, '777444111Z', 1, 2);

--VI copiado en clase, da errores sera algun tipo de dato o algo
insert into pertenece (fecha_alta, aportacion, cuota, cif_asociacion, dni_socio)
    values (deafult, 500, 60, '777444111Z', '12345678X');
insert into pertenece (fecha_alta, aportacion, cuota, cif_asociacion, dni_socio)
    values (deafult, default, default, '777444111Z', '36925814R');
insert into pertenece (fecha_alta, aportacion, cuota, cif_asociacion, dni_socio)
    values (deafult, 500, 60, '777444111Z', '78945612A');
insert into pertenece (fecha_alta, aportacion, cuota, cif_asociacion, dni_socio)
    values (deafult, 500, 60, '666666666P', '36925814R');
