// To parse this JSON data, do
//
//     final datosAsesor = datosAsesorFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<DatosAsesor> datosAsesorFromJson(String str) => List<DatosAsesor>.from(
    json.decode(str).map((x) => DatosAsesor.fromJson(x)));

String datosAsesorToJson(List<DatosAsesor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DatosAsesor {
  String idAsesor;
  String rfc;
  String abreviaturaProfesional;
  String licenciatura;
  String maestria;
  String doctorado;
  String idPersona;
  String nombrePersona;
  String apellido1;
  String apellido2;
  String telefono;
  String correoElectronico;
  String numIne;
  String curp;
  String nombreDepartamento;
  String nombreTecnologico;

  DatosAsesor({
    required this.idAsesor,
    required this.rfc,
    required this.abreviaturaProfesional,
    required this.licenciatura,
    required this.maestria,
    required this.doctorado,
    required this.idPersona,
    required this.nombrePersona,
    required this.apellido1,
    required this.apellido2,
    required this.telefono,
    required this.correoElectronico,
    required this.numIne,
    required this.curp,
    required this.nombreDepartamento,
    required this.nombreTecnologico,
  });

  factory DatosAsesor.fromJson(Map<String, dynamic> json) => DatosAsesor(
        idAsesor: json["Id_asesor"],
        rfc: json["RFC"],
        abreviaturaProfesional: json["Abreviatura_profesional"],
        licenciatura: json["Licenciatura"],
        maestria: json["Maestria"],
        doctorado: json["Doctorado"],
        idPersona: json["Id_persona"],
        nombrePersona: json["Nombre_persona"],
        apellido1: json["Apellido1"],
        apellido2: json["Apellido2"],
        telefono: json["Telefono"],
        correoElectronico: json["Correo_electronico"],
        numIne: json["Num_ine"],
        curp: json["Curp"],
        nombreDepartamento: json["Nombre_departamento"],
        nombreTecnologico: json["Nombre_tecnologico"],
      );

  Map<String, dynamic> toJson() => {
        "Id_asesor": idAsesor,
        "RFC": rfc,
        "Abreviatura_profesional": abreviaturaProfesional,
        "Licenciatura": licenciatura,
        "Maestria": maestria,
        "Doctorado": doctorado,
        "Id_persona": idPersona,
        "Nombre_persona": nombrePersona,
        "Apellido1": apellido1,
        "Apellido2": apellido2,
        "Telefono": telefono,
        "Correo_electronico": correoElectronico,
        "Num_ine": numIne,
        "Curp": curp,
        "Nombre_departamento": nombreDepartamento,
        "Nombre_tecnologico": nombreTecnologico,
      };
}
