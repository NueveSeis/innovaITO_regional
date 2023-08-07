// To parse this JSON data, do
//
//     final datosEstudiante = datosEstudianteFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<DatosEstudiante> datosEstudianteFromJson(String str) =>
    List<DatosEstudiante>.from(
        json.decode(str).map((x) => DatosEstudiante.fromJson(x)));

String datosEstudianteToJson(List<DatosEstudiante> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DatosEstudiante {
  String matricula;
  String? fechaNacimiento;
  String? promedio;
  String? expectativa;
  String? nombreCarrera;
  String id;
  String? nombreDepartamento;
  String? nombreTecnologico;
  String nombrePersona;
  String? apellido1;
  String? apellido2;
  String? telefono;
  String correoElectronico;
  String? numIne;
  String? curp;
  String? tipoGenero;
  String? numeroSemestre;
  String? nombreNivel;

  DatosEstudiante({
    required this.matricula,
    required this.fechaNacimiento,
    required this.promedio,
    required this.expectativa,
    required this.nombreCarrera,
    required this.id,
    required this.nombreDepartamento,
    required this.nombreTecnologico,
    required this.nombrePersona,
    required this.apellido1,
    required this.apellido2,
    required this.telefono,
    required this.correoElectronico,
    required this.numIne,
    required this.curp,
    required this.tipoGenero,
    required this.numeroSemestre,
    required this.nombreNivel,
  });

  factory DatosEstudiante.fromJson(Map<String, dynamic> json) =>
      DatosEstudiante(
        matricula: json["Matricula"],
        fechaNacimiento: json["Fecha_Nacimiento"],
        promedio: json["Promedio"],
        expectativa: json["Expectativa"],
        nombreCarrera: json["Nombre_carrera"],
        id: json["Id_persona"],
        nombreDepartamento: json["Nombre_departamento"],
        nombreTecnologico: json["Nombre_tecnologico"],
        nombrePersona: json["Nombre_persona"],
        apellido1: json["Apellido1"],
        apellido2: json["Apellido2"],
        telefono: json["Telefono"],
        correoElectronico: json["Correo_electronico"],
        numIne: json["Num_ine"],
        curp: json["Curp"],
        tipoGenero: json["Tipo_genero"],
        numeroSemestre: json["Numero_semestre"],
        nombreNivel: json["Nombre_nivel"],
      );

  Map<String, dynamic> toJson() => {
        "Matricula": matricula,
        "Fecha_Nacimiento": fechaNacimiento,
        "Promedio": promedio,
        "Expectativa": expectativa,
        "Nombre_carrera": nombreCarrera,
        "Id_persona": id,
        "Nombre_departamento": nombreDepartamento,
        "Nombre_tecnologico": nombreTecnologico,
        "Nombre_persona": nombrePersona,
        "Apellido1": apellido1,
        "Apellido2": apellido2,
        "Telefono": telefono,
        "Correo_electronico": correoElectronico,
        "Num_ine": numIne,
        "Curp": curp,
        "Tipo_genero": tipoGenero,
        "Numero_semestre": numeroSemestre,
        "Nombre_nivel": nombreNivel,
      };
}
