--conexion trabajo
drop table PERSONA cascade constraints;
drop table ARTISTA cascade constraints;
drop table CLIENTE cascade constraints;
drop table OBRA cascade constraints;
drop table MUSEO cascade constraints;
drop table ESTILO cascade constraints;
drop table TIENE cascade constraints;

create table PERSONA (
DNI varchar2(9) primary key,
NUMERO_TICKET number(38)
constraint NUMERO_TICKET_CK check(NUMERO_TICKET > 0)
);

create table ARTISTA (
DNI_PERSONA varchar2(9),
DIRIGIR_DIRIGE varchar2(9),
    constraint DNI_PERSONA_PK primary key (DNI_PERSONA),
    constraint DNI_PERSONA_FK foreign key (DNI_PERSONA)
        references PERSONA (DNI),
    constraint DIRIGIR_DIRIGE_FK foreign key (DIRIGIR_DIRIGE)
        references ARTISTA (DNI_PERSONA)    
);

create table CLIENTE (
DNI_CLIENTE varchar2(9),
    constraint DNI_CLIENTE_PK primary key (DNI_CLIENTE),
    constraint DNI_CLIENTE_FK foreign key (DNI_CLIENTE)
        references PERSONA (DNI)
);

create table MUSEO (
ID_MUSEO number(10) primary key,
CODIGO_POSTAL number(5),
CALLE varchar2(25)
);

create table OBRA (
ID_OBRA number(38) primary key,
FECHA_CREACION varchar2(10),
GENERO varchar2(10) DEFAULT 'Drama',
NOMBRE_CREACION varchar2(15),

DNI_ARTISTA varchar2(9) not null,
DNI_CLIENTE1 varchar2(9) not null,
ID_MUSEO1 number(10) not null,
    constraint DNI_ARTISTA_FK foreign key (DNI_ARTISTA)
        references ARTISTA(DNI_PERSONA),
    constraint DNI_CLIENTE1_FK foreign key (DNI_CLIENTE1)
        references CLIENTE(DNI_CLIENTE),
    constraint ID_MUSEO1_FK foreign key (ID_MUSEO1)
        references MUSEO(ID_MUSEO)
);

create table ESTILO (
NOMBRE_ESTILO varchar2(15) primary key,
AÑO_CREACION number(4)
);

create table TIENE (
NOMBRE_ESTILO1 varchar2(15),
DNI_PERSONA varchar2(9),
    constraint TIENEEE_PK primary key(NOMBRE_ESTILO1, DNI_PERSONA),
     constraint DNI_PERSONAAA_FK foreign key (DNI_PERSONA)
        references ARTISTA(DNI_PERSONA),
    constraint NOMBRE_ESTILO__FK foreign key(NOMBRE_ESTILO1 )
        references ESTILO(NOMBRE_ESTILO )
  
);