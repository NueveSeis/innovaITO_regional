// To parse this JSON data, do
//
//     final datosEstudianteRegional = datosEstudianteRegionalFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<DatosEstudianteRegional> datosEstudianteRegionalFromJson(String str) =>
    List<DatosEstudianteRegional>.from(
        json.decode(str).map((x) => DatosEstudianteRegional.fromJson(x)));

String datosEstudianteRegionalToJson(List<DatosEstudianteRegional> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DatosEstudianteRegional {
  String nombrePersona;
  dynamic apellido1;
  dynamic apellido2;
  dynamic telefono;
  dynamic correoElectronico;
  dynamic numIne;
  dynamic curp;

  DatosEstudianteRegional({
    required this.nombrePersona,
    required this.apellido1,
    required this.apellido2,
    required this.telefono,
    required this.correoElectronico,
    required this.numIne,
    required this.curp,
  });

  factory DatosEstudianteRegional.fromJson(Map<String, dynamic> json) =>
      DatosEstudianteRegional(
        nombrePersona: json["Nombre_persona"],
        apellido1: json["Apellido1"],
        apellido2: json["Apellido2"],
        telefono: json["Telefono"],
        correoElectronico: json["Correo_electronico"],
        numIne: json["Num_ine"],
        curp: json["Curp"],
      );

  Map<String, dynamic> toJson() => {
        "Nombre_persona": nombrePersona,
        "Apellido1": apellido1,
        "Apellido2": apellido2,
        "Telefono": telefono,
        "Correo_electronico": correoElectronico,
        "Num_ine": numIne,
        "Curp": curp,
      };
}
