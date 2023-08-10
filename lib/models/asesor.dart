// To parse this JSON data, do
//
//     final asesor = asesorFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Asesor> asesorFromJson(String str) =>
    List<Asesor>.from(json.decode(str).map((x) => Asesor.fromJson(x)));

String asesorToJson(List<Asesor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Asesor {
  String idAsesor;
  String rfc;
  String abreviaturaProfesional;
  String licenciatura;
  String maestria;
  String doctorado;
  String idPersona;
  String idDepartamento;

  Asesor({
    required this.idAsesor,
    required this.rfc,
    required this.abreviaturaProfesional,
    required this.licenciatura,
    required this.maestria,
    required this.doctorado,
    required this.idPersona,
    required this.idDepartamento,
  });

  factory Asesor.fromJson(Map<String, dynamic> json) => Asesor(
        idAsesor: json["Id_asesor"],
        rfc: json["RFC"],
        abreviaturaProfesional: json["Abreviatura_profesional"],
        licenciatura: json["Licenciatura"],
        maestria: json["Maestria"],
        doctorado: json["Doctorado"],
        idPersona: json["Id_persona"],
        idDepartamento: json["Id_departamento"],
      );

  Map<String, dynamic> toJson() => {
        "Id_asesor": idAsesor,
        "RFC": rfc,
        "Abreviatura_profesional": abreviaturaProfesional,
        "Licenciatura": licenciatura,
        "Maestria": maestria,
        "Doctorado": doctorado,
        "Id_persona": idPersona,
        "Id_departamento": idDepartamento,
      };
}
