// To parse this JSON data, do
//
//     final proyectosJuradoAsjs = proyectosJuradoAsjsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ProyectosJuradoAsjs> proyectosJuradoAsjsFromJson(String str) =>
    List<ProyectosJuradoAsjs>.from(
        json.decode(str).map((x) => ProyectosJuradoAsjs.fromJson(x)));

String proyectosJuradoAsjsToJson(List<ProyectosJuradoAsjs> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProyectosJuradoAsjs {
  String idPersona;
  String idJurado;
  String? rfc;
  String nombrePersona;
  String apellido1;
  String apellido2;
  String? telefono;
  String? correoElectronico;
  String? idArea;
  String? nombreArea;
  String? idCategoria;
  String? nombreCategoria;
  String cantidadProyectos;

  ProyectosJuradoAsjs({
    required this.idPersona,
    required this.idJurado,
    required this.rfc,
    required this.nombrePersona,
    required this.apellido1,
    required this.apellido2,
    required this.telefono,
    required this.correoElectronico,
    required this.idArea,
    required this.nombreArea,
    required this.idCategoria,
    required this.nombreCategoria,
    required this.cantidadProyectos,
  });

  factory ProyectosJuradoAsjs.fromJson(Map<String, dynamic> json) =>
      ProyectosJuradoAsjs(
        idPersona: json["Id_persona"],
        idJurado: json["Id_jurado"],
        rfc: json["Rfc"],
        nombrePersona: json["Nombre_persona"],
        apellido1: json["Apellido1"],
        apellido2: json["Apellido2"],
        telefono: json["Telefono"],
        correoElectronico: json["Correo_electronico"],
        idArea: json["Id_area"],
        nombreArea: json["Nombre_area"],
        idCategoria: json["Id_categoria"],
        nombreCategoria: json["Nombre_categoria"],
        cantidadProyectos: json["Cantidad_proyectos"],
      );

  Map<String, dynamic> toJson() => {
        "Id_persona": idPersona,
        "Id_jurado": idJurado,
        "Rfc": rfc,
        "Nombre_persona": nombrePersona,
        "Apellido1": apellido1,
        "Apellido2": apellido2,
        "Telefono": telefono,
        "Correo_electronico": correoElectronico,
        "Id_area": idArea,
        "Nombre_area": nombreArea,
        "Id_categoria": idCategoria,
        "Nombre_categoria": nombreCategoria,
        "Cantidad_proyectos": cantidadProyectos,
      };
}
