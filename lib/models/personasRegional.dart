// To parse this JSON data, do
//
//     final personasRegional = personasRegionalFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<PersonasRegional> personasRegionalFromJson(String str) =>
    List<PersonasRegional>.from(
        json.decode(str).map((x) => PersonasRegional.fromJson(x)));

String personasRegionalToJson(List<PersonasRegional> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PersonasRegional {
  String idPersona;
  dynamic nombrePersona;
  dynamic apellido1;
  dynamic apellido2;
  dynamic telefono;
  dynamic correoElectronico;
  dynamic numIne;
  dynamic curp;

  PersonasRegional({
    required this.idPersona,
    required this.nombrePersona,
    required this.apellido1,
    required this.apellido2,
    required this.telefono,
    required this.correoElectronico,
    required this.numIne,
    required this.curp,
  });

  factory PersonasRegional.fromJson(Map<String, dynamic> json) =>
      PersonasRegional(
        idPersona: json["Id_persona"],
        nombrePersona: json["Nombre_persona"],
        apellido1: json["Apellido1"],
        apellido2: json["Apellido2"],
        telefono: json["Telefono"],
        correoElectronico: json["Correo_electronico"],
        numIne: json["Num_ine"],
        curp: json["Curp"],
      );

  Map<String, dynamic> toJson() => {
        "Id_persona": idPersona,
        "Nombre_persona": nombrePersona,
        "Apellido1": apellido1,
        "Apellido2": apellido2,
        "Telefono": telefono,
        "Correo_electronico": correoElectronico,
        "Num_ine": numIne,
        "Curp": curp,
      };
}
