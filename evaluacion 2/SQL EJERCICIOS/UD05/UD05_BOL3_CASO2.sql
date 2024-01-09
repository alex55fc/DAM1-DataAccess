--conexion UD05_BOL3_CASO2
drop table Enfermedad cascade constraints;
drop table Paciente cascade constraints;
drop table Historial cascade constraints;
drop table Linea_Historial cascade constraints;
drop table Localizacion cascade constraints;
drop table Estancias_Pacientes cascade constraints;

CREATE TABLE Enfermedad (
    id_enfermedad NUMBER(10) PRIMARY KEY,
    nombre VARCHAR2(10) unique NOT NULL,
    descripcion VARCHAR2(10),
    t_recuperacion NUMBER(10)
);

CREATE TABLE Paciente (
    id_paciente NUMBER(10) PRIMARY KEY,
    nombre VARCHAR2(10) ,
    apellidos VARCHAR2(10) ,
    f_nacimiento VARCHAR2(10) ,
    poblacion VARCHAR2(10) ,
    id_medico NUMBER(10),
    
    constraint id_medico_fk FOREIGN KEY (id_medico) REFERENCES Paciente(id_paciente)
);

CREATE TABLE Historial (
    id_historial NUMBER(10) PRIMARY KEY,
    grupo_sanguineo VARCHAR2(10) NOT NULL,
    id_paciente NUMBER(10),
    constraint id_paciente_fk FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente)
);

CREATE TABLE Linea_Historial (
    num_linea NUMBER(10),
    f_inicio varchar2(10),
    f_fin varchar2(10),
    síntomas varchar2(10),
    observaciones varchar2(10),
    
    id_historial NUMBER(10),
    id_enfermedad NUMBER(10) not null,
        constraint Linea_historial_pk primary key (num_linea, id_historial),
        constraint id_historial_fk foreign key (id_historial) references Historial(id_historial),
        constraint id_enfermedad_fk foreign key (id_enfermedad) references Enfermedad(id_enfermedad),
        constraint f_fin_ck check (f_fin > f_inicio)
);

CREATE TABLE Localizacion (
    id_localizacion NUMBER(10) PRIMARY KEY,
    cp NUMBER(10) ,
    ciudad VARCHAR2(10) ,
    riesgo NUMBER(10) default 1
);

CREATE TABLE Estancias_Pacientes (
    f_salida NUMBER(10),
    
    id_paciente NUMBER(10),
    id_localizacion NUMBER(10),
    f_entrada NUMBER(10),
        constraint Estancias_Pacientes primary key (id_paciente, id_localizacion, f_entrada),
        constraint id_paciente_fk1 foreign key (id_paciente) references Paciente(id_paciente),
        constraint id_localizacion_fk foreign key (id_localizacion) references Localizacion(id_localizacion)
);
