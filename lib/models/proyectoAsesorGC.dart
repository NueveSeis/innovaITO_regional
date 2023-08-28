// To parse this JSON data, do
//
//     final proyectoAsesorGc = proyectoAsesorGcFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ProyectoAsesorGc> proyectoAsesorGcFromJson(String str) =>
    List<ProyectoAsesorGc>.from(
        json.decode(str).map((x) => ProyectoAsesorGc.fromJson(x)));

String proyectoAsesorGcToJson(List<ProyectoAsesorGc> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProyectoAsesorGc {
  String nombrePersona;
  String apellido1;
  String apellido2;
  String telefono;
  String correoElectronico;
  String numIne;
  String curp;

  ProyectoAsesorGc({
    required this.nombrePersona,
    required this.apellido1,
    required this.apellido2,
    required this.telefono,
    required this.correoElectronico,
    required this.numIne,
    required this.curp,
  });

  factory ProyectoAsesorGc.fromJson(Map<String, dynamic> json) =>
      ProyectoAsesorGc(
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
